import axios from 'axios';
import AsyncStorage from '@react-native-community/async-storage';
import firebase from 'react-native-firebase';
import DeviceInfo from 'react-native-device-info';
import NetInfo from '@react-native-community/netinfo';
import _ from 'lodash';
import { getCurrentIpAddress, authorizationFailed } from './Controller';
import AppConfig from './Config';
import { currentLocales } from '@utilities/I18n';
import Toast from '@utilities/Toast';
import I18n from '@utilities/I18n';
import PinCode from '@utilities/PinCode';
import NavigationService from '@utilities/NavigationService';
import { firebaseConfigLocalValue } from '@utilities/Firebase';

const AUTHENTICATE = axios.create({
    baseURL: AppConfig.authenticateUrl,
    timeout: (AppConfig.timeoutService >= 0) ? AppConfig.timeoutService : 60000,
})

const API = axios.create({
    baseURL: AppConfig.mainApiUrl,
    timeout: (AppConfig.timeoutService >= 0) ? AppConfig.timeoutService : 60000,
})

const API_BACKUP = axios.create({
    baseURL: firebaseConfigLocalValue().backupApi ? firebaseConfigLocalValue().backupApi : AppConfig.backupApiUrl,
    timeout: (AppConfig.timeoutService >= 0) ? AppConfig.timeoutService : 60000,
})

/*
HttpService option request
ex HttpService.
option = { 
    url: '', //*
    method: 'post',
    headers: {},
    data: {} 
}
*/
const HttpService = async (option) => {
    const data_response = await axios({
        method: 'post',
        ...option
    }).then(response => {
        console.log(`Response_HttpService ${option.url||''} => `, response);
        return response
    }).catch(error => {
        console.log('error.config => ', error.config);
        console.log(`Error_HttpService ${option.url||''} => `, error.response);
        if (_.isEmpty(error.response)) return { status: 500 }
        return error.response
    });
    return {
        ...data_response.data,
        httpStatus: data_response.status
    }
}

const AuthenticateProvider = async (url = '/', data = {}, option = {}) => {
    const data_response = await AUTHENTICATE({
        url: url,
        data: data,
        method: 'post',
        ...option
    }).then(response => {
        console.log(`Response_AuthenticateProvider ${url} = `, response);
        return response.data
    }).catch(error => {
        console.log('error.config => ', error.config);
        console.log(`Error_AuthenticateProvider ${url} = `, error.response);
        if(_.isEmpty(error.response)) return false
        return error.response
    })

    return data_response
}

/* ServiceProvider ex.
post => ServiceProvider('/login', {'usename': '1234'}, { headers: { } })
get => ServiceProvider('/login?abc=123', {}, { method: 'GET' })
*/

const ServiceProvider = async (url = '/', data = {}, option = {}) => {
    const { headers, responseType, noneAuth, ...otherOption } = option;
    const asyncData = await AsyncStorage.multiGet(['ACCESS_TOKEN', 'REFRESH_TOKEN', 'isDEV']);

    const serviceRunningIsDEV = new Object();
    const serviceBackupRunningIsDEV = new Object();
    
    if (!_.isEmpty(asyncData[2][1]) && (asyncData[2][1] == 'true' || asyncData[2][1] == 'false')) {
        serviceRunningIsDEV['baseURL'] = (asyncData[2][1] === 'true') ? AppConfig.mainApiUrl_DEV : AppConfig.mainApiUrl
        serviceBackupRunningIsDEV['baseURL'] = (asyncData[2][1] === 'true') ?
            (firebaseConfigLocalValue().backupApi_DEV ? firebaseConfigLocalValue().backupApi_DEV : AppConfig.backupApiUrl_DEV)
            :
            (firebaseConfigLocalValue().backupApi ? firebaseConfigLocalValue().backupApi : AppConfig.mainApiUrl)
    }

    const Headers = {
        Authorization: `Bearer ${(noneAuth === true) ? '' : (asyncData[0][1] || '')}`,
        Lang_locale: `${currentLocales() ? ( currentLocales().slice(0, 2).toLocaleLowerCase() == 'th' ? 'th' : 'en') : 'th'}`,
        ...headers
    }
    const Data = {
        channel: 'mobile_app',
        app_version: DeviceInfo.getVersion(),
        refresh_token: asyncData[1][1] || undefined,
        unique_id: DeviceInfo.getUniqueId(),
        ip_address: getCurrentIpAddress(),
        ...data
    }

    let data_response = await API({
        ...serviceRunningIsDEV,
        url: url,
        headers: Headers,
        data: Data,
        method: 'post',
        ...otherOption
    }).then(response => {
        console.log(`Response_MainServiceProvider ${url} => `, response);
        return response
    }).catch(error => {
        console.log('error.config => ', error.config);
        console.log(`Error_MainServiceProvider ${url} => `, error, error.response);

        if(error.response){
            if(catchEventForServiceProvider(error.response)){
                return { data: error.response.data || null, status: 204 }
            }
            return error.response
        }else {
            firebase.crashlytics().recordError(0, _.toString(error))
            return { status: 0 }
        }
    })

    if ((_.has(data_response, 'status')) && (data_response.status === 0)) {
        data_response = await API_BACKUP({
            ...serviceBackupRunningIsDEV,
            url: url,
            headers: Headers,
            data: Data,
            method: 'post',
            ...otherOption
        }).then(response => {
            console.log(`Response_BackupServiceProvider ${url} => `, response);
            return response
        }).catch(error => {
            console.log('error.config => ', error.config);
            console.log(`Error_BackupServiceProvider ${url} => `, error, error.response);
            
            if(error.response){
                if(catchEventForServiceProvider(error.response)){
                    return { data: error.response.data || null, status: 204 }
                }
                return error.response
            }else {
                firebase.crashlytics().recordError(1, _.toString(error))
                throw error.response || false
            }
        })
    }

    //new Token
    if (_.has(data_response,'data.NEW_TOKEN') && !_.isEmpty(data_response.data.NEW_TOKEN)) {
        await AsyncStorage.setItem('ACCESS_TOKEN', data_response.data.NEW_TOKEN)
        console.log('save new token => ', data_response.data.NEW_TOKEN);
        const { NEW_TOKEN, ...otherData } = data_response.data;
        data_response.data = otherData;
    }

    if(responseType == 'plainText'){
        return {
            data: data_response.data,
            httpStatus: data_response.status
        }
    }

    return { 
        ...data_response.data,
        httpStatus: data_response.status
    }
}

//service error event
const catchEventForServiceProvider = (response) => {
    const { 
        data,
        // config, 
        status 
    } = response;
    if(status && status == 401) {
        if (_.has(data, 'RESPONSE_CODE')) {
            if(_.has(data, 'RESPONSE_CODE') && (data.RESPONSE_CODE == 'WS0046')){ //Access Token หมดอายุให้ไปหน้า PIN เพื่อรีโทเคน
                console.log(data.RESPONSE_CODE, data.RESPONSE_MESSAGE);

                console.log('== getCurrentRoute == ', NavigationService.getCurrentRoute().routeName);

                if(NavigationService.getCurrentRoute().routeName != 'InitChecking' && NavigationService.getCurrentRoute().routeName != 'AppLanding'){  
                    Toast.show({
                        title: I18n.t('notice'),
                        text: data.RESPONSE_MESSAGE ? data.RESPONSE_MESSAGE : I18n.t('theSessionHasExpired'),
                        showOneToast: true,
                        duration: 5000,
                        type: 'warning'
                    })

                    NavigationService.navigate('AppLanding', { type: 'expire_token_inapp' })
                }
            } else {
                //Access Token หมดอายุหรือ Refresh Token ไม่ถูกต้อง
                console.log(data.RESPONSE_CODE, data.RESPONSE_MESSAGE);
                Toast.show({
                    title: I18n.t('error'),
                    text: data.RESPONSE_MESSAGE ? data.RESPONSE_MESSAGE : I18n.t('cannotAccessToServer'),
                    showOneToast: true,
                    duration: 5000,
                    type: 'error'
                })
                authorizationFailed();
                if(PinCode && PinCode.active()){
                    PinCode.close()
                }
            }
            // switch (data.RESPONSE_CODE) {
            //     case 'WS0014': //Access Token หมดอายุและ Refresh Token ไม่ถูกต้อง
            //         console.log(data.RESPONSE_CODE, data.RESPONSE_MESSAGE);
            //         Toast.show({
            //             title: I18n.t('error'),
            //             text: data.RESPONSE_MESSAGE ? data.RESPONSE_MESSAGE : I18n.t('cannotAccessToServer'),
            //             showOneToast: true,
            //             textColor: Colors.red
            //         })
            //         authorizationFailed();
            //         break;
            //     case 'WS0046': //Access Token หมดอายุให้ไปหน้า PIN เพื่อรีโทเคน
            //         console.log(data.RESPONSE_CODE, data.RESPONSE_MESSAGE);
            //         Toast.show({
            //             title: I18n.t('error'),
            //             text: data.RESPONSE_MESSAGE ? data.RESPONSE_MESSAGE : I18n.t('cannotAccessToServer'),
            //             showOneToast: true,
            //             textColor: Colors.red
            //         })
    
            //         if(NavigationService.getCurrentRoute().routeName != 'AppLanding'){  
            //             NavigationService.navigate('AppLanding')
            //         }
            //         // PinCode.open({
            //         //     type: 'get', //get, set, change
            //         //     serviceType: 'checking',
            //         //     allowTouchID: true,
            //         //     allowForgotPIN: false,
            //         //     allowPinCancel: false,
            //         //     randomNumberPad: false
            //         // }, callback => {
            //         //     if (callback == 'done') {
            //         //         console.log('done');
            //         //         ServiceProvider(config.url, config.data)
            //         //         // return axios.request(config);
            //         //     } else if (callback == 'cancel') {
            //         //         console.log('cancel pin')
            //         //     }
            //         // })
            //         break;
            // }
        }
        return true
    }
    return false
}

const Service = {

    //#region system
    async fetchRootConfigMenu() {
        const data_response = await HttpService({
            method: 'get',
            url: `${AppConfig.rootConfigUrl}/config_app_splus.php`,
            params: { //params for method: 'get', data for method: 'post'
                app_id: DeviceInfo.getBundleId()
            }
        })
        if(data_response.httpStatus >= 300){
            return { ONLINE: true }
        }
        return data_response;
    },
    //#endregion

    //#region auth
    async fetchIpAddress() {
        let data_response = await HttpService({
            method: 'get',
            url: 'https://api.gensoft.co.th/utility/ip_checker'
        })
        if (data_response.httpStatus >= 300) {
            data_response = await HttpService({
                method: 'get',
                url: 'https://api.ipify.org/?format=json'
            })
        }
        if (data_response.httpStatus >= 300) {
            data_response = await HttpService({
                method: 'get',
                url: 'https://ip-api.io/json'
            })
        }
        if(data_response.httpStatus >= 300){
            data_response = await NetInfo.fetch().then(state => {
                return { ip: state.details.ipAddress || 'unknown', httpStatus: 200 }
            }).catch(() => {
                return { ip: 'unknown', httpStatus: 500 }
            })
        }
        if(data_response.httpStatus >= 300){
            return { ip: 'unknown' } 
        }
        return data_response
    },
    async requestApiKey(data, headers) {
        const data_response = await AuthenticateProvider('/request_api-key', data, headers);
        return data_response;
    },
    async requestLogin(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/login/check_login_and_insert_userlog', data, headers);
        return data_response;
    },
    async updateLockAccount(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/login/update_lock_account', data, headers);
        return data_response;
    },
    async checkLoged(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/login/check_logged', data, headers);
        return data_response;
    },
    async checkLogon(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/login/check_userlog', data, headers);
        return data_response;
    },
    async checkPinWelcome(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/pin/check_pin_welcome', data, headers);
        return data_response;
    },
    async checkPin(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/pin/check_pin', data, headers);
        return data_response;
    },
    async requestChangePin(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/pin/update_change_pin', data, headers);
        return data_response;
    },
    async requestResetPin(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/pin/update_reset_pin', data, headers);
        return data_response;
    },
    async checkMembership(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/register/check_membership', data, headers);
        return data_response;
    },
    async requestCreateAccount(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/register/insert_member_account', data, headers);
        return data_response;
    },
    async checkPassword(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/password/check_password', data, headers);
        return data_response;
    },
    async changePassword(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/password/update_change_password', data, headers);
        return data_response;
    },
    async requestLogout(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/home/update_logout', data, headers);
        return data_response;
    },
    async authorizationAutoload(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/autoload', data, headers);
        return data_response;
    },
    //#endregion

    //#region service
    //#region fetch data
    async fetchMemberInfo(data, headers) { //ข้อมูลสมาชิก
        const data_response = await ServiceProvider('/mobile_and_web-control/home/fetch_member_info', data, headers);
        return data_response;
    },
    async fetchMenu(data, headers) { //เมนู
        const data_response = await ServiceProvider('/mobile_and_web-control/home/fetch_menu', data, headers);
        return data_response;
    },
    async fetchSettingManageNotification(data, headers) { //จัดการแจ้งเตือน
        const data_response = await ServiceProvider('/mobile_and_web-control/setting/fetch_manage_notify', data, headers);
        return data_response;
    },
    async fetchSettingManageDevice(data, headers) { //จัดการอุปกรณ์
        const data_response = await ServiceProvider('/mobile_and_web-control/setting/fetch_manage_device', data, headers);
        return data_response;
    },
    async fetchShareInfo(data, headers) { //หุ้น
        const data_response = await ServiceProvider('/mobile_and_web-control/share/fetch_share_info', data, headers);
        return data_response;
    },
    async fetchLoanByType(data, headers) { //ข้อมูลเงินกู้
        const data_response = await ServiceProvider('/mobile_and_web-control/loan/fetch_loan_type', data, headers);
        return data_response;
    },
    async fetchLoanStatememt(data, headers) { //statement เงินกู้
        const data_response = await ServiceProvider('/mobile_and_web-control/loan/fetch_loan_statement', data, headers);
        return data_response;
    },
    async fetchLoanCredit(data, headers) { //สิทธิกู้
        const data_response = await ServiceProvider('/mobile_and_web-control/credit/fetch_credit_loan', data, headers);
        return data_response;
    },
    async fetchGuaranteeYouCollWho(data, headers) { //คุณคั้าใคร
        const data_response = await ServiceProvider('/mobile_and_web-control/guarantee/fetch_guarantee_ucollwho', data, headers);
        return data_response;
    },
    async fetchGuaranteeWhoCollYou(data, headers) { //ใครค้ำคุณ
        const data_response = await ServiceProvider('/mobile_and_web-control/guarantee/fetch_guarantee_whocollu', data, headers);
        return data_response;
    },
    async fetchDividendInfo(data, headers) { //ข้อมูลปันผล
        const data_response = await ServiceProvider('/mobile_and_web-control/dividend/fetch_dividend_info', data, headers);
        return data_response;
    },
    async fetchPaymentMonthlyInfo(data, headers) { //ข้อมูลชำระรายเดือน
        const data_response = await ServiceProvider('/mobile_and_web-control/kpmonth/fetch_keeping_list', data, headers);
        return data_response;
    },
    async fetchPaymentMonthlyDetail(data, headers) { //รายละเอียดชำระรายเดือน
        const data_response = await ServiceProvider('/mobile_and_web-control/kpmonth/fetch_keeping_detail', data, headers);
        return data_response;
    },
    async fetchBeneficiaryInfo(data, headers) { //ผู้รับผลประโยชน์
        const data_response = await ServiceProvider('/mobile_and_web-control/beneficiary/fetch_beneficiary_info', data, headers);
        return data_response;
    },
    async fetchDepositInfo(data, headers) { //ข้อมูลเงินฝาก
        const data_response = await ServiceProvider('/mobile_and_web-control/deposit/fetch_deposit_type', data, headers);
        return data_response;
    },
    async fetchDepositStatement(data, headers) { //statement เงินฝาก
        const data_response = await ServiceProvider('/mobile_and_web-control/deposit/fetch_deposit_statement', data, headers);
        return data_response;
    },
    async fetchHistory(data, headers) { //แจ้งเตือน
        const data_response = await ServiceProvider('/mobile_and_web-control/history/fetch_history', data, headers);
        return data_response;
    },
    async fetchHistoryBadgeNumber(data, headers) { //Badge number
        const data_response = await ServiceProvider('/mobile_and_web-control/history/fetch_history_badge_number', data, headers);
        return data_response;
    },
    async fetchNews(data, headers) { //ข่าว
        const data_response = await ServiceProvider('/mobile_and_web-control/news/fetch_all_news', data, headers);
        return data_response;
    },
    async fetchNewsDetail(data, headers) { //รายระเอียดข่าว
        const data_response = await ServiceProvider('/mobile_and_web-control/news/fetch_detail_news', data, headers);
        return data_response;
    },
    async fetchActivities(data, headers) { //กิจกรรม
        const data_response = await ServiceProvider('/mobile_and_web-control/activities/fetch_all_activities', data, headers);
        return data_response;
    },
    async fetchUpcomingActivities(data, headers) { //กิจกรรมที่ใกล้มาถึง
        const data_response = await ServiceProvider('/mobile_and_web-control/activities/fetch_upcoming_activities', data, headers);
        return data_response;
    },
    async fetchActivityDetail(data, headers) { //รายละเอียดกิจกรรม
        const data_response = await ServiceProvider('/mobile_and_web-control/activities/fetch_activities_detail', data, headers);
        return data_response;
    },
    async fetchTheme(data, headers) { //ธีม
        const data_response = await ServiceProvider('/mobile_and_web-control/setting/fetch_theme', data, headers);
        return data_response;
    },
    async fetchAssistType(data, headers) { //ข้อมูลสวัสดิการ
        const data_response = await ServiceProvider('/mobile_and_web-control/assist/fetch_assist_type', data, headers);
        return data_response;
    },
    async fetchAssistStatement(data, headers) { //statement สวัสดิการ
        const data_response = await ServiceProvider('/mobile_and_web-control/assist/fetch_assist_statement', data, headers);
        return data_response;
    },
    async fetchInsureInfo(data, headers) { //ข้อมูลประกัน
        const data_response = await ServiceProvider('/mobile_and_web-control/insure/fetch_insure_info', data, headers);
        return data_response;
    },
    async fetchIntrateLoan(data, headers) { //ดอกเบี้้ยเงินกู้
        const data_response = await ServiceProvider('/mobile_and_web-control/tablesimulatepayment/fetch_intrate_loan', data, headers);
        return data_response;
    },
    async fetchLastDepositStatement(data, headers) { //Statement เงินฝากบัญชีล่าสุด
        const data_response = await ServiceProvider('/mobile_and_web-control/deposit/fetch_last_deposit_statement', data, headers);
        return data_response;
    },
    async fetchLastLoanStatement(data, headers) { //Statement เงินกู้บัญชีล่าสุด
        const data_response = await ServiceProvider('/mobile_and_web-control/loan/fetch_last_loan_statement', data, headers);
        return data_response;
    },
    async calculateSimulatePayment(data, headers) { //คำนวนตารางรับชำระ
        const data_response = await ServiceProvider('/mobile_and_web-control/tablesimulatepayment/calculate_simulate_payment', data, headers);
        return data_response;
    },
    async fetchReportKeepingMonthly(data, headers) { //ใบรับเงินชำระรายเดือน
        const data_response = await ServiceProvider('/mobile_and_web-control/kpmonth/report_keeping_monthly', data, headers);
        return data_response;
    },
    async fetchReceiptList(data, headers) { //ใบเสร็จ
        const data_response = await ServiceProvider('/mobile_and_web-control/receipt/fetch_receipt_list', data, headers);
        return data_response;
    },
    async fetchReceiptReport(data, headers) { //ใบเสร็จ
        const data_response = await ServiceProvider('/mobile_and_web-control/receipt/report_receipt', data, headers);
        return data_response;
    },
    async fetchInitAnnounce(data, headers) { //Announce
        const data_response = await ServiceProvider('/mobile_and_web-control/home/init_announce', data, headers);
        return data_response;
    },

    //#region fetch data for tranfer
    async fetchInitDataForConsent(data, headers) { //ผูกบัญชี
        const data_response = await ServiceProvider('/mobile_and_web-control/bindaccount/init_data_for_consent', data, headers);
        return data_response;
    },
    async fetchInitDataForConsentPending(data, headers) { //ขอมูล ผูกบัญชี สำหรับบัญชีที่ padding
        const data_response = await ServiceProvider('/mobile_and_web-control/bindaccount/init_data_for_consent_pending', data, headers);
        return data_response;
    },
    async requestConsentRegId(data, headers) { //kbank
        const data_response = await ServiceProvider('/mobile_and_web-control/bindaccount/request_consent_reg_id', data, headers);
        return data_response;
    },
    async fetchAccountBeenBind(data, headers) { //จัดการบัญชี
        const data_response = await ServiceProvider('/mobile_and_web-control/manageaccount/fetch_account_been_bind', data, headers);
        return data_response;
    },
    async fetchAccountBeenAllow(data, headers) { //จัดการบัญชี
        const data_response = await ServiceProvider('/mobile_and_web-control/manageaccount/fetch_account_been_allow', data, headers);
        return data_response;
    },
    async fetchInitAccountDepositAllow(data, headers) { //จัดการบัญชี
        const data_response = await ServiceProvider('/mobile_and_web-control/manageaccount/init_account_deposit_allow', data, headers);
        return data_response;
    },
    async fetchBindAccountDepositTransaction(data, headers) { //บัญชีที่ผูกสำหรับฝากเงิน
        const data_response = await ServiceProvider('/mobile_and_web-control/depositfundtransfer/fetch_bind_account_transaction', data, headers);
        return data_response;
    },
    async fetchBindAccountWithdrawTransaction(data, headers) { //บัญชีที่ผูกสำหรับถอนเงิน
        const data_response = await ServiceProvider('/mobile_and_web-control/withdrawfundtransfer/fetch_bind_account_transaction', data, headers);
        return data_response;
    },
    async fetchWithdrawFeeFundTransfer(data, headers) { //ค่าปรับถอนเงินฝาก
        const data_response = await ServiceProvider('/mobile_and_web-control/withdrawfundtransfer/get_fee_fund_transfer', data, headers);
        return data_response;
    },
    async fetchAllowAccountForBuyShare(data, headers) { //บัญชีสำหรับซื้อหุ้น
        const data_response = await ServiceProvider('/mobile_and_web-control/buyshare/fetch_allow_account_transfer', data, headers);
        return data_response;
    },
    async fetchAllowAccountForRepayLoan(data, headers) { //บัญชีสำหรับจ่ายเงินกู้
        const data_response = await ServiceProvider('/mobile_and_web-control/repayloan/fetch_allow_account_transfer_and_loan', data, headers);
        return data_response;
    },
    async fetchHistoryTransaction(data, headers) { //ประวัติการทำรายการ
        const data_response = await ServiceProvider('/mobile_and_web-control/manageaccount/fetch_history_transaction', data, headers);
        return data_response;
    },

    //inside
    async fetchInsideAllowAccountTransfer(data, headers) { //บัญชีที่อนุญาติให้โอนภายใน
        const data_response = await ServiceProvider('/mobile_and_web-control/transferinsidecoop/fetch_allow_account_transfer', data, headers);
        return data_response;
    },
    async fetchInsideDataAccountDestination(data, headers) { //หาข้อมูลบัญชี
        const data_response = await ServiceProvider('/mobile_and_web-control/transferinsidecoop/fetch_data_account_destination', data, headers);
        return data_response;
    },
    async fetchFavVerifyDestination(data, headers) { //ตรวจสอบบัญชี
        const data_response = await ServiceProvider('/mobile_and_web-control/favorite/verify_destination', data, headers);
        return data_response;
    },
    async fetchInsideFeeFundTransfer(data, headers) { //ค่าปรับโอนภายใน
        const data_response = await ServiceProvider('/mobile_and_web-control/transferinsidecoop/get_fee_fund_transfer', data, headers);
        return data_response;
    },
    //#endregion fetch data for tranfer

    //#endregion fetch data

    //#region request
    async requestSendOtp(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/otp/send_otp', data, headers);
        return data_response;
    },
    async requestResendOtp(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/otp/resend_otp', data, headers);
        return data_response;
    },
    async checkOtp(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/otp/check_otp', data, headers);
        return data_response;
    },
    
    //#region transfer request
    async requestDepositVerifyData(data, headers) { //ตรวจสอบข้อมูล
        const data_response = await ServiceProvider('/mobile_and_web-control/depositfundtransfer/request_verify_data', data, headers);
        return data_response;
    },
    async requestDepositBankPayment(data, headers) { //ฝากเงิน bank
        const data_response = await ServiceProvider('/mobile_and_web-control/depositfundtransfer/request_deposit_bank_payment', data, headers);
        return data_response;
    },
    async requestWithdrawVerifyData(data, headers) { //ตรวจสอบข้อมูล
        const data_response = await ServiceProvider('/mobile_and_web-control/withdrawfundtransfer/request_verify_data', data, headers);
        return data_response;
    },
    async requestWithdrawBankPayment(data, headers) { //ถอนเงิน bank
        const data_response = await ServiceProvider('/mobile_and_web-control/withdrawfundtransfer/request_withdraw_bank_payment', data, headers);
        return data_response;
    },
    async requesUnbindConsent(data, headers) { //ยกเลิกผูกบัญชี
        const data_response = await ServiceProvider('/mobile_and_web-control/bindaccount/request_unbind_consent', data, headers);
        return data_response;
    },
    //inside
    async requestTransferInCoop(data, headers) { //โอนภายใน
        const data_response = await ServiceProvider('/mobile_and_web-control/transferinsidecoop/fund_transfer_in_coop', data, headers);
        return data_response;
    },
    //#endregion transfer request

    //#endregion request

    //#region insert
    async insertAndUpdateDepositMemo(data, headers) { //บันทึกช่วยจำ
        const data_response = await ServiceProvider('/mobile_and_web-control/deposit/insert_and_update_memo_deposit', data, headers);
        return data_response;
    },

    async insertAndUpdateAliasDeposit(data, headers) { //ชื่อบัญชี
        const data_response = await ServiceProvider('/mobile_and_web-control/deposit/insert_and_update_alias_deposit', data, headers);
        return data_response;
    },

    //#region insert for tranfer
    async insertAllowAccountTransaction(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/manageaccount/insert_allow_account_transaction', data, headers);
        return data_response;
    },

    async insertFavAccount(data, headers) {//เพิ่มบัญชีโปรด
        const data_response = await ServiceProvider('/mobile_and_web-control/favorite/insert_fav_account', data, headers);
        return data_response;
    },
    //#endregion

    //#endregion insert

    //#region update
    async updateSettingManageNotification(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/setting/update_manage_notify', data, headers);
        return data_response;
    },
    async updateReadHistory(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/history/update_read_history', data, headers);
        return data_response;
    },
    async updateReadAllHistory(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/history/update_all_read_history', data, headers);
        return data_response;
    },
    async updateForgetPassword(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/password/update_forget_password', data, headers);
        return data_response;
    },
    async insertAcceptLogAnnounce(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/home/insert_accept_log_announce', data, headers);
        return data_response;
    },

    //#region update data for tranfer
    async updateAccountBeenAllow(data, headers) { //สถานะบัญชีที่อนุญาติทำธุรกรรม
        const data_response = await ServiceProvider('/mobile_and_web-control/manageaccount/update_data_account_been_allow', data, headers);
        return data_response;
    },
    async updateAccountBeenBind(data, headers) { //สถานะบัญชีที่ผูก
        const data_response = await ServiceProvider('/mobile_and_web-control/manageaccount/update_data_account_been_bind', data, headers);
        return data_response;
    },
    async updateLimitPerTrans(data, headers) { //วงเงิน
        const data_response = await ServiceProvider('/mobile_and_web-control/manageaccount/update_limit_per_trans', data, headers);
        return data_response;
    },
    //#endregion update data for tranfer

    //#endregion update

    //#region upload
    async uploadMemberAvatar(data, headers) {
        const data_response = await ServiceProvider('/mobile_and_web-control/home/upload_avatar_and_update_member_info', data, headers);
        return data_response;
    },
    //#endregion upload

    //#region delete
    async deleteDepositMemo(data, headers) { //ลบบันทึกช่วยจำ
        const data_response = await ServiceProvider('/mobile_and_web-control/deposit/delete_memo_deposit', data, headers);
        return data_response;
    },
    async deleteDevice(data, headers) { //ลบอุปกรณ์
        const data_response = await ServiceProvider('/mobile_and_web-control/setting/update_manage_device', data, headers);
        return data_response;
    },
    async deleteHistory(data, headers) { //ลบแจ้งเตือน
        const data_response = await ServiceProvider('/mobile_and_web-control/history/delete_history', data, headers);
        return data_response;
    },
    async deleteAllHistory(data, headers) { //ลบแจ้งเตือนทั้งหมด
        const data_response = await ServiceProvider('/mobile_and_web-control/history/delete_all_history', data, headers);
        return data_response;
    },
    async deleteDepositAliasName(data, headers) { //ลบชื่อบัญชี
        const data_response = await ServiceProvider('/mobile_and_web-control/deposit/delete_alias_deposit', data, headers);
        return data_response;
    },
    //#endregion delete

    //#endregion service

}

export default Service;