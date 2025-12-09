import { Dimensions, Platform, BackHandler, PixelRatio } from 'react-native';
import AsyncStorage from '@react-native-community/async-storage';
import DeviceInfo from 'react-native-device-info';
import RNExitApp from 'react-native-exit-app';
import RNFetchBlob from 'rn-fetch-blob';
import FingerprintScanner from 'react-native-fingerprint-scanner';
import Animated, { Easing } from 'react-native-reanimated';
import _ from 'lodash';
import io from 'socket.io-client';
import isURL from 'validator/lib/isURL';
import isDataURI from 'validator/lib/isDataURI';
import SHA1 from "crypto-js/sha1";
import CryptoJS from 'crypto-js';
import VersionCheck from 'react-native-version-check';
import { AlertFullscreen } from '@utilities/Alert';
import Service from './Service';
import AppConfig from './Config';
import NavigationService from '@utilities/NavigationService';
import I18n, { currentLocales } from '@utilities/I18n';

const { width, height } = Dimensions.get('window');

const dirs = RNFetchBlob.fs.dirs;
const FILE_PREFIX = Platform.OS === "ios" ? "" : "file://";

let ipAddress = 'unknown';
export const getCurrentIpAddress = () => {
    return ipAddress
}

export const setupCurrentIpAddress = async () => {
    const currentIp = await Service.fetchIpAddress().catch(e => { return false });
    if (currentIp && !!currentIp.ip) {
        ipAddress = currentIp.ip
    }
}

export const inNumberFormat = (value, floatMode = 'fix') => {
    if (!_.isNaN(Number(value)) && _.isNumber(Number(value))) {
        if(floatMode == 'dynamic'){
            if((value == 0) && (value !== '0.')){
                return '0.00'
            }
            return value.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        }
        return Number(value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    } else {
        const num = value.toString().replace(/([A-z]|[^\w]*)/g, '');
        if (!_.isNaN(num) && !_.isEmpty(num) && _.isNumber(Number(num))) {
            if(floatMode == 'dynamic'){
                return num.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }
            return Number(num).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        }
        return '0.00'
    }
}

export const outNumberFormat = (valueString, type = 'string') => {
    if (!!valueString) {
        if (type == 'number') {
            return Number(valueString.toString().replace(/,/g, ''));
        }
        return valueString.toString().split('.00')[0].replace(/,/g, '').toString();
    }
    return valueString
}

export const outSpaceReplace = (value) => {
    if (_.isString(value)) {
        return value.replace(/ /g, '')
    }
    return value
}

export const exitApp = () => {
    Platform.OS == 'ios' ? RNExitApp.exitApp() : BackHandler.exitApp();
}

export const removeAsyncData = async () => {
    //ค่าที่ไม่ต้อง ลบลิ้ง
    const keepsAsync = await AsyncStorage.multiGet(['FONT_SIZE', 'THEME', 'LANGUAGE', 'isDEV', 'FIRST_LAUNCHED', 'HIDE_ANNOUNCE']);
    const newKeeping = _.filter(keepsAsync, x => {
        return !!x[1]
    })
    await AsyncStorage.clear();

    const touchid = await FingerprintScanner.isSensorAvailable().then(() => {
        if(Platform.OS === 'android' && Platform.Version < 23){
            return false
        }
        return true
    }).catch(() => false)
    const touchidValue = touchid ? (AppConfig.initSettingTouchId.toString() || 'false') : 'unsupport';
    const initNewAsync = [['TOUCH_ID', touchidValue], ['HIDE_ACCOUNT', (AppConfig.initSettingHideAccount.toString() || 'true')]]
    await AsyncStorage.multiSet([...newKeeping, ...initNewAsync]);
}

export const welcomeTime = () => {
    const _Date = new Date();
    if ((_Date.getHours() >= 0) && (_Date.getHours() < 4)) {
        return I18n.t('night');
    }else if ((_Date.getHours() > 3) && (_Date.getHours() < 12)) {
        return I18n.t('morning');
    } else if ((_Date.getHours() > 11) && (_Date.getHours() < 18)) {
        return I18n.t('afternoon');
    } else if ((_Date.getHours() > 17) && (_Date.getHours() < 21)) {
        return I18n.t('evening');
    } else if (_Date.getHours() > 20) {
        return I18n.t('night');
    }
    return I18n.t('hello');
}

export const diffMonths = (dt2 = new Date(), dt1 = new Date()) => {
    let diff = (dt2.getTime() - dt1.getTime()) / 1000;
    diff /= (60 * 60 * 24 * 7 * 4);
    return Math.abs(Math.round(diff));
}

export const shortDateText = (date, yearType = 'AD', split = false) => { //#yearType BE=พ.ศ, AD=ค.ศ #split return object {day, month, year}
    const monthList = ['ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.'];
    if (date) {
        const _Date = () => new Date();
        const day = _Date(date).getDate();
        const month = monthList[_Date(date).getMonth()];
        const year = yearType == 'BE' ? (_Date(date).getUTCFullYear() + 543) : _Date(date).getUTCFullYear();
        if (split) {
            return { day, month, year }
        }
        return `${day} ${month} ${year}`;
    }
    return date;
}

export const fullDateText = (date, yearType = 'AD', split = false, time = false) => { //yearType BE=พ.ศ, AD=ค.ศ #split return object {day, month, year}
    const monthList = ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฏาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'];
    if (date) {
        const _Date = () => new Date();
        const day = _Date(date).getDate();
        const month = monthList[_Date(date).getMonth()];
        const year = yearType == 'BE' ? (_Date(date).getUTCFullYear() + 543) : _Date(date).getUTCFullYear();
        if (split) {
            if (time) {
                const hours = _Date(date).getHours();
                const minutes = _Date(date).getMinutes()
                return { day, month, year, hours, minutes }
            }
            return { day, month, year }
        }
        if (time) {
            const hours = _Date(date).getHours();
            const minutes = _Date(date).getMinutes()
            return `${day} ${month} ${year} ${hours}:${minutes}`;
        }
        return `${day} ${month} ${year}`;
    }
    return date
}

export const formatDate = (date = new Date(), format = 'd/m/y') => {
    const getDate = new Date(date);
    const format1 = format.split('/');
    const format2 = format.split('-');
    let dateFormat = '';
    if (format1.length > 1) {
        _.forEach(format1, (element, index) => {
            [1, 2].includes(index) && (dateFormat += '/');
            switch (element) {
                case 'd': dateFormat += (getDate.getDate() < 10 ? '0' + getDate.getDate() : getDate.getDate()); break;
                case 'm': dateFormat += ((getDate.getMonth() + 1) < 10 ? '0' + (getDate.getMonth() + 1) : (getDate.getMonth() + 1)); break;
                case 'y': dateFormat += getDate.getFullYear(); break;
            }
        })
        return dateFormat;
    } else if (format2.length > 1) {
        _.forEach(format2, (element, index) => {
            [1, 2].includes(index) && (dateFormat += '-');
            switch (element) {
                case 'd': dateFormat += (getDate.getDate() < 10 ? '0' + getDate.getDate() : getDate.getDate()); break;
                case 'm': dateFormat += ((getDate.getMonth() + 1) < 10 ? '0' + (getDate.getMonth() + 1) : (getDate.getMonth() + 1)); break;
                case 'y': dateFormat += getDate.getFullYear(); break;
            }
        })
        return dateFormat;
    }
}

export const randomId = () => {
    return (Math.random().toString(36) + Date.now().toString(36)).substr(2, 10);
}

const showAlertAppUpdate = () => {
    AlertFullscreen.show(
        {
            show: true,
            type: 'app_update', // server_lost, maintenance, no_internet, custom
            exitApp: false,
            enableCloseIcon: true,
            refName: 'alertAppUpdate'
        }
    )
}

export const checkAppUpdate = async () => {
    const needUpdate = await VersionCheck.needUpdate().catch(e => { console.log('VersionCheck ERROE ', e) })
    if(!_.isEmpty(needUpdate)){
        console.log('++checkAppUpdate++ ', needUpdate);
        if (needUpdate.isNeeded) {
            const checkNotShowAlert = await AsyncStorage.getItem('NOT_SHOW_ALERT_APPUPDATE', 'false');
            (!checkNotShowAlert || checkNotShowAlert == 'false') && showAlertAppUpdate()
        } else {
            AsyncStorage.removeItem('NOT_SHOW_ALERT_APPUPDATE');
        }
    }
}

export const getCurrentTheme = async () => {
    let response = {
        type: 'image',
        themeName: 'ค่าเริ่มต้น',
        path: null,
        color: []
    }
    const currentTheme = await AsyncStorage.getItem('THEME');
    if (currentTheme) {
        if (currentTheme == 'default') {
            response = getDefaultTheme();
        } else {
            const isColorBackground = currentTheme.split('Color^');
            if (isColorBackground.length > 1) {
                let colorBackground = isColorBackground[1].split(',');
                if (_.compact(colorBackground).length > 0) {
                    if (colorBackground.length < 2) {
                        colorBackground.push(colorBackground[0])
                    }
                } else {
                    colorBackground = []
                }
                response = {
                    ...response,
                    type: 'color',
                    themeName: 'กำหนดสีเอง',
                    color: colorBackground
                }
            } else {
                const themeSplitString = currentTheme.split('<=@ThemE@=>');
                if (themeSplitString.length > 1) {
                    const themeCache = await checkCacheTheme(themeSplitString[1], 'filename');
                    if (themeCache.cache) {
                        response = {
                            ...response,
                            themeName: themeSplitString[0],
                            path: themeCache.path
                        }
                    } else {
                        const themeUrl = await getThemeUrlByThemeName(themeSplitString[0]);
                        if (!!themeUrl) {
                            response = {
                                ...response,
                                themeName: themeSplitString[0],
                                path: FILE_PREFIX + await downloadThemeToCache(themeUtl)
                            }
                        } else {
                            await AsyncStorage.setItem('THEME', 'default');
                            response = await getDefaultTheme();
                        }
                    }
                } else {
                    await AsyncStorage.setItem('THEME', 'default');
                    response = await getDefaultTheme();
                }
            }
        }
    } else {
        await AsyncStorage.setItem('THEME', 'default');
        response = await getDefaultTheme();
    }
    return response
}

export const getDefaultTheme = async () => {
    let response = {
        type: 'image',
        themeName: 'ค่าเริ่มต้น',
        path: null,
        color: []
    }
    const data = {
        resolution: width * PixelRatio.get(),
        menu_component: 'SettingTheme'
    }
    const themeData = await Service.fetchTheme(data).catch(e => { return false });
    if (themeData && themeData.httpStatus != 204) {
        const defaultThemeIndex = themeData.theme.findIndex(x => x.name == themeData.default);
        if (defaultThemeIndex != -1) {
            console.log('defaultThemeIndex ', defaultThemeIndex);

            const uri = themeData.theme[defaultThemeIndex].url;
            const themeCache = await checkCacheTheme(uri);
            if (themeCache.cache) {
                response = {
                    ...response,
                    path: themeCache.path
                }
            } else {
                response = {
                    ...response,
                    path: FILE_PREFIX + await downloadThemeToCache(uri)
                }
            }
        }
    }
    return response
}

export const getThemeUrlByThemeName = async (themeName) => {
    const data = {
        resolution: width * PixelRatio.get(),
        menu_component: 'SettingTheme'
    }
    const themeData = await Service.fetchTheme(data).catch(e => { return false });
    if (themeData && themeData.httpStatus != 204) {
        const themeIndex = themeData.theme.findIndex(x => x.name == themeName);
        if (themeIndex != -1) {
            return themeData.theme[themeIndex].url
        }
    }
    return null
}

export const checkCacheTheme = async (uri, checkBy = 'url') => { //checkBy (url, filename) #default url
    let response = {
        cache: false,
        path: null
    }
    let filename = uri;
    if (checkBy == 'url') {
        filename = conventToCacheFileNameEncryption(uri);
    }
    const isCache = await RNFetchBlob.fs.exists(`${dirs.CacheDir}/ImageCache/THEME/${filename}`)
    if (isCache) {
        response = {
            cache: true,
            path: `${FILE_PREFIX}${dirs.CacheDir}/ImageCache/THEME/${filename}`
        }
    }
    return response;
}

export const downloadThemeToCache = async (uri) => {
    return RNFetchBlob
        .config({
            timeout: 60000,
            path: `${dirs.CacheDir}/ImageCache/THEME/${conventToCacheFileNameEncryption(uri)}`
        })
        .fetch('GET', uri)
        .then((res) => {
            console.log('The file saved to ', res.path())
            return res.path();
        })
        .catch(e => {
            console.log('download error ');
            return null;
        })
}

export const conventToCacheFileNameEncryption = (uri) => {
    if (!!uri) {
        let path = uri.substring(uri.lastIndexOf("/"));
        path = path.indexOf("?") === -1 ? path : path.substring(path.lastIndexOf("."), path.indexOf("?"));
        const ext = path.indexOf(".") === -1 ? ".jpg" : path.substring(path.indexOf("."));
        return `${SHA1(uri) + ext}`;
    }
    return null
}

export const downloadFileToStorage = async (uri = undefined, config = {}) => {

    let path = uri.substring(uri.lastIndexOf("/"));
    path = path.indexOf("?") === -1 ? path : path.substring(path.lastIndexOf("."), path.indexOf("?"));
    const ext = path.indexOf(".") === -1 ? ".pdf" : path.substring(path.indexOf("."));
    const defaultDirPath = Platform.OS == 'android' ? `${dirs.DownloadDir}/${AppConfig.appNameForFilePath}` : dirs.DocumentDir;
    const saveToPath = `${_.has(config, 'path') ? config.path : defaultDirPath}/${_.has(config, 'filename') ? config.filename : 'download_' + new Date().toISOString().split('T')[0]}${ext}`;

    return RNFetchBlob
        .config({
            path: saveToPath,
            addAndroidDownloads: {
                useDownloadManager: true,
                notification: false,
                mediaScannable: true
            },
            ...config.RNFetchBlobConfig
        })
        .fetch(_.has(config, 'method') ? config.method : 'GET', uri, {
            ...config.headers
        })
        .then((res) => {
            console.log('download file saved to ', res.path())
            return {
                result: true,
                path: res.path()
            }
        }).catch(e => {
            console.log('download file error ', e);
            return {
                result: false,
                path: null
            }
        })
}

export const authorizationFailed = () => {
    removeAsyncData().then(() => {
        NavigationService.navigate('Auth')
    })
}

export const decodeJWT = (token = '') => {
    try {
        return JSON.parse(atob(token.split('.')[1]));
    } catch (e) {
        return null;
    }
};

export const genJWTToken = (payloadObj) => {
    const initPayload = {
        channel: 'mobile_app',
        resource_app_id: DeviceInfo.getBundleId(),
        device_name: `${DeviceInfo.getBrand()} ${DeviceInfo.getModel()}`,
        ip_address: getCurrentIpAddress(),
        exp: (Math.floor(Date.now() / 1000) + 60) // 1นาที
    }

    const key = AppConfig.DB_DEV ? AppConfig.secretkeyJWT_DEV : AppConfig.secretkeyJWT;
    const header = CryptoJS.enc.Utf8.parse(JSON.stringify({ alg: "HS256", typ: "JWT" }));
    const payload = CryptoJS.enc.Utf8.parse(JSON.stringify(payloadObj || initPayload));
    
    const unsignedToken = `${base64url(header)}.${base64url(payload)}`;
    
    const signature_key = base64url(CryptoJS.HmacSHA256(unsignedToken, key));

    return `${base64url(header)}.${base64url(payload)}.${signature_key}`;
}

const base64url = (source) => {
    // Encode in classical base64
    let encodedSource = CryptoJS.enc.Base64.stringify(source);

    // Remove padding equal characters
    encodedSource = encodedSource.replace(/=+$/, '');

    // Replace characters according to base64url specifications
    encodedSource = encodedSource.replace(/\+/g, '-');
    encodedSource = encodedSource.replace(/\//g, '_');

    return encodedSource;
}

export const runTimingAnimated = (clock, duration = 200, value, dest, callback = () => {}) => {
    const state = {
        finished: new Animated.Value(0),
        position: value,
        time: new Animated.Value(0),
        frameTime: new Animated.Value(0),
    };

    const config = {
        duration: duration,
        toValue: dest,
        easing: Easing.inOut(Easing.ease),
    };

    return Animated.block([
        Animated.cond(Animated.clockRunning(clock), 0, [
            // If the clock isn't running we reset all the animation params and start the clock
            Animated.set(state.finished, 0),
            Animated.set(state.time, 0),
            Animated.set(state.position, value),
            Animated.set(state.frameTime, 0),
            Animated.set(config.toValue, dest),
            Animated.startClock(clock),
        ]),
        // we run the step here that is going to update position
        Animated.timing(clock, state, config),
        // if the animation is over we stop the clock
        Animated.cond(state.finished, [Animated.stopClock(clock), Animated.call([state.position], callback)] ),
        // we made the block return the updated position
        state.position,
    ]);
}

export const defaultcalendar = {
    monthNames: ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'],
    monthNamesShort: ['ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.'],
    dayNames: ['อาทิตย์', 'จันทร์', 'อังคาร', 'พุธ', 'พฤหัสบดี', 'ศุกร์', 'เสาร์'],
    dayNamesShort: ['อา.', 'จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.']
}

export const getHeaderTitle = (headerTitle = '') => {
    return _.isString(headerTitle) ? headerTitle : (_.isObject(headerTitle) ? (
        currentLocales() == 'en-US' ? (_.has(headerTitle, 'en') ? headerTitle.en : '') : (_.has(headerTitle, 'th') ? headerTitle.th : '')
    ) : '')
}

export const diffTimeMinutes = (dt2 = new Date(), dt1 = new Date()) => {
    let diff = (dt2.getTime() - dt1.getTime()) / 1000;
    diff /= 60;
    return Math.abs(Math.round(diff));
}

export const deffTimeDay = (dt1 = new Date(), dt2 = new Date()) => {
    let daysDiff = (dt2.getTime() - dt1.getTime()) / (1000 * 3600 * 24);
    return Math.abs(Math.round(daysDiff));
}

export const checkIsURL = (url) => {
    return (!_.isEmpty(url) && (isURL(url, { require_protocol: true, host_blacklist: ['localhost', '127.0.0.1'] }) || isDataURI(url)))
}

export const randomColor = () => {
    return '#'+Math.floor(Math.random()*16777215).toString(16)
}

export const socket = io('https://ws.gensoft.co.th', { secure: true, reconnection: true, reconnectionAttempts: ((_.has(AppConfig, 'limitReConnectSocketIO') && AppConfig.limitReConnectSocketIO) || 30) });

export const connectSocketIO = async () => {
    const access_token = await AsyncStorage.getItem("ACCESS_TOKEN", undefined);
    if(!socket.connected){
        socket.connect()
    }
    console.log('socket.emit subscribe');

    socket.emit('subscribe', {
        coop_id: AppConfig.coopId,
        token: access_token,
        unique_id: DeviceInfo.getUniqueId(),
        device_name: `${DeviceInfo.getBrand()} ${DeviceInfo.getModel()}`,
        app_version: DeviceInfo.getVersion()
    });
}

export const disconnectSocketIO = () => {
    console.log('disconnectSocketIO ', socket.connected, socket.disconnected);
    
    if(socket.connected){
        socket.disconnect()
    }
}

export const reconnectSocketIO = () => {
    console.log('reconnectSocketIO ', socket.connected, socket.disconnected);
    
    if(socket.connected){
        socket.disconnect()
    }
    connectSocketIO()
}