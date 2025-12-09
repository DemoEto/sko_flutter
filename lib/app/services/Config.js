export default AppConfig = {
    //#region system
    DB_DEV: false, //database test for dev ?
    authenticateUrl: 'https://api.gensoft.co.th/authenticate',
    mainApiUrl: 'https://demo.gensoft.co.th/Service-Demo',
    mainApiUrl_DEV: 'https://demo.gensoft.co.th/Service-Demo-Test', //url api for dev ทำงานเมื่อ baseTest = true
    backupApiUrl: '',
    backupApiUrl_DEV: '', //url backup api for dev ทำงานเมื่อ baseTest = true
    secretkeyJWT: 'DemoGcoop+Connect^999999*!&',
    secretkeyJWT_DEV: 'DemoGcoop+Connect^999999*!&',
    timeoutService: 60000, //limit service timeout *ms
    rootConfigUrl: 'https://mobilecore.gensoft.co.th/ROOTCONFIG',
    manualUrl: 'https://www.gensoft.co.th/mobile/manual/index.php?coopid=',
    deeplinkScheme: 'https://demo.icoopsiam.com/',
    //#endregion

    //#region app
    appName: 'Gcoop',
    appNameForFilePath: 'Gcoop', //*ห้ามเว้นวรรค
    fullAppName: 'Gcoop Application',
    coopName: 'บริษัท เจนซอฟต์ จำกัด',
    coopName_ENG: 'Gensoft Company Limited',
    coopId: 'G00000',
    coopTel: '0637891888',
    coopMail: 'mobilesupport@gensoft.co.th',
    supportMail: 'mobilesupport@gensoft.co.th',
    //#endregion

    //#region default value
    inputMembernoMaxLength: 8,
    inputPasswordMaxLength: 50,
    minPasswordLength: 6, //ขั้นต่ำการตั้งรหัสผ่าน
    initSettingFontSize: 'normal', //ค่าเริ่มต้นขนาดตัวอักษร ** small, normal, large
    initSettingHideAccount: true, //ค่าเริ่มต้นการตั้งค่าแสดงเลขบัญชีบางส่วน
    initSettingEnableHomeViewBalance: false, //แสดงยอดเงินหน้า home
    initSettingTouchId: false, //ค่าเริ่มต้นการตั้งค่าเปิดใช้ TouchId,FaceId
    initSettingLanguage: 'th-TH', //th-TH, en-US
    initHeaderGradientColor: ['#4881CE', '#486BB5'], //สี nav bar
    statusbarIsTransparent: true, //if false จะสีเดียวกับ header
    customStatusbarColor: undefined, // custom statusbar color default = undefined
    initNavHeaderRadius: undefined, // init headerRadius undefined = horizontalScale(18)
    defaultDepNoFormat: '[000] [00] [00000]',
    defaultAccountColor: ['#EEEEEE', '#FFFFFF'],
    transactionAuth: 'PIN', // PIN, OTP, NONE #รูปแบบการยืนยันการทำธุรกรรม
    limitBackgroundTask: 5, //limit ที่ต้องยืนยัน Pincode ใหม่เมื่อแอพทำงานเป็น background *นาที set 0 ถ้าต้องการให้เช็คทุกครั้งที่ทำงาน background
    pageComponentHasBackgroundImage: false, //แสดงพื้นหลังหน้า component
    overrideComponentBackgroundColor: 'transparent', //default transparent
    splashScreenType: 'default', //default, image
    limitReConnectSocketIO: 30, //limit reconnect socketIO

    //login
    login: {
        maxPasswordAttempts: 6
    },

    register: {
        disableRegister: false, //ปิดปุ่มสมัครสมาชิก default false
        disableTextNote: ``,
        requiredEmail: false, //บังคับกรอก email
        verifyOtp: true, //ยืนยัน otp
        textOfTermsAndConditions: `${
         `  1. การเข้าใช้งานระบบข้อมูลสมาชิกจะต้องทำการสมัครเข้าใช้งานระบบและต้องเป็นสมาชิกของ สหกรณ์ออมทรัพย์ จำกัด เท่านั้น\n`+
         `  2. เพื่อความเรียบร้อยในการสมัครใช้งาน ระบบฯ และเพื่อยืนยันผู้สมัคร กรุณาทำตามขั้นตอนที่ระบบแนะนำ\n`+
         `  3. หากชื่อหรือหมายเลขสมาชิกของท่านได้มีการสมัครใช้งานแล้ว โดยท่านไม่ทราบ หรือทำการสมัครด้วยตัวท่านเองกรุณาแจ้งเจ้าหน้าที่เพื่อทำการตรวจสอบความถูกต้องต่อไป\n`+
         `  4. เพื่อความปลอดภัยในข้อมูลของท่าน หากสหกรณ์พบว่ามีบุคคลแอบอ้างใช้งานบัญชีของท่านในการเข้าสู่ระบบ สหกรณ์จะบังคับบุคคลนั้นออกจากระบบ โดยไม่ต้องแจ้งให้ทราบ\n`+
         `  5. หากข้อมูลรายละเอียดของสมาชิกไม่ถูกต้องในระบบ แล้วมีข้อสงสัยหรือต้องการทำการเปลี่ยนแปลงปรับปรุงข้อมูลให้สมาชิกติดต่อเจ้าหน้าที่เพื่อทำการแก้ไขปรับปรุงเปลี่ยนแปลงข้อมูลต่อไป\n`+
         `  6. ข้าพเจ้าได้อ่านข้อตกลงดังกล่าวและยินยอมในเงื่อนไขต่างๆที่ทางสหกรณ์ออมทรัพย์ จำกัด กำหนดไว้รวมทั้งที่สหกรณ์จะได้กำหนดเพิ่มเติมแก้ไข หรือเปลี่ยนแปลงในภายหน้า ซึ่งให้ถือเป็นส่วนหนึ่งของเงื่อนไขและข้อกำหนดนี้ด้วย`
        }`
    },

    //pincode
    pincode: {
        circlePasswordColor: ['#9E9E9ECC', '#BDBDBDCC'],
        passwordLength: 6, //default จำนวน pin
        maxAttempts: 6, //default กรอกผิดสูงสุด
        timeLocked: 30000, //default เวลาการ lock pin *ms
        randomNumberPad: false, //สุ่มเลข keypad,
        overrideBackgroundColor: 'transparent', //พื้นหลัง default: 'transparent'
        pinImage: 'default', //default, coop *deafult คือ รูปสมาชิก 
    },

    //home menu
    menu: {
        menuHeaderId: [
            24, //setting
            42, //notification
            43, //memberinfo
        ],
        menuExtraId: [
            1, //เงินฝาก
            2 //เงินกู้
        ]
    },

    //ผู้รับผลประโยชน์
    beneficiary: {
        use_pdf: false,
    },

    //ค้ำประกัน
    guarantee: {
        singleTab: false, //ถ้า true จะไม่แสดง tab ข้อมูลจะเป็นไปตาม param
        defaultTab: 'YouCollWho' // YouCollWho <-คุณค้ำใคร, WhoCollYou <-ใครค้ำคุณ
    },

    //เรียกเก็บ
    paymentMonthly: {
        info_showPeriod: false,
        detail_showPeriod: false,
    },

    //แจ้งเตือน
    notification: {
        page_defaultTab: 'news', //<= news, transaction
        initDataLimit: 10 // limit จำนวนข้อมูลแต่ละ page
    },

    //เงินฝาก
    depositInfo: {
        default_pattern_deptaccount_no: 'xxx-xx-xxxxx',
        maxLengthAliasName: 100
    },

    //statement เงินฝาก
    depositStatement: {
        maxLengthMemo: 140, //ความยาวบันทึกช่วยจำ
    },

    //ปันผล
    dividendInfo: {

    },

    //หุ้น
    shareInfo: {
        show_slip_no: true, //แสดงเลขใบเสร็จ
    },

    //ข้อมูลสมาชิก
    memberInfo: {
        show_signature: false //แสดงลายมือชื่อ
    },

    //ประกัน
    insureInfo: {
        show_remark: false //แสดงหมายเหตุ
    },

    //otp
    otp: {
        enabled: true,
        passcodeLength: 6, //ขนาดรหัส
    },

    //ตั้งค่า
    setting: { //ตั้งค่า
        setLargeFont: false //ตัวเลือก set font ขนาดใหญ่
    },

    //บัญชีโปรด
    favoriteAccount: {
        favNameLength: 100 //ความยาวชื่อ
    },
    
    //เเลนดิ้ง
    landing: {
        footerBgColor: 'rgba(255,255,255,0.8)',
        footerIconColor: '#FFFFFF', //พื้นหลังเข้ม => 'white'
        footerIconBgColor: '#1976D2', //พื้นหลังเข้ม => 'rgba(0,0,0,0.1)'
        contentBg: "rgba(255,255,255,0.8)",
        showCoopNameInHeader: true // default true
    },

    slipInfo: {
        show_slipno_onlist: false, //แสดงเลข slip ที่ชื่อรายการ slip
    },

    //ธุรกรรม
    transaction: {
        //manage account
        limitAddCoopAccount: 0, // 0 = unlimit
        limitAddBindBankAccount: 0, //0 = unlimit
        isEnableSwitchOnOffAccount: false, //อนุญาติ เปิด-ปิดการใช้งานบัญชี
        webHelpUrl: '',
    },

    //#endregion
}