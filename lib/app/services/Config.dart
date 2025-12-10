class AppConfig {
  //#region system
  static const bool DB_DEV = false;

  static const String authenticateUrl = 'https://api.gensoft.co.th/authenticate';
  static const String mainApiUrl = 'https://demo.gensoft.co.th/Service-Demo';
  static const String mainApiUrl_DEV = 'https://demo.gensoft.co.th/Service-Demo-Test';

  static const String backupApiUrl = '';
  static const String backupApiUrl_DEV = '';

  static const String secretkeyJWT = 'DemoGcoop+Connect^999999*!&';
  static const String secretkeyJWT_DEV = 'DemoGcoop+Connect^999999*!&';

  static const int timeoutService = 60000;

  static const String rootConfigUrl = 'https://mobilecore.gensoft.co.th/ROOTCONFIG';
  static const String manualUrl = 'https://www.gensoft.co.th/mobile/manual/index.php?coopid=';
  static const String deeplinkScheme = 'https://demo.icoopsiam.com/';
  //#endregion

  //#region app
  static const String appName = 'Gcoop';
  static const String appNameForFilePath = 'Gcoop';
  static const String fullAppName = 'Gcoop Application';

  static const String coopName = 'บริษัท เจนซอฟต์ จำกัด';
  static const String coopName_ENG = 'Gensoft Company Limited';
  static const String coopId = 'G00000';

  static const String coopTel = '0637891888';
  static const String coopMail = 'mobilesupport@gensoft.co.th';
  static const String supportMail = 'mobilesupport@gensoft.co.th';
  //#endregion

  //#region default value
  static const int inputMembernoMaxLength = 8;
  static const int inputPasswordMaxLength = 50;
  static const int minPasswordLength = 6;

  static const String initSettingFontSize = 'normal';
  static const bool initSettingHideAccount = true;
  static const bool initSettingEnableHomeViewBalance = false;
  static const bool initSettingTouchId = false;
  static const String initSettingLanguage = 'th-TH';

  static const List<String> initHeaderGradientColor = ['#4881CE', '#486BB5'];

  static const bool statusbarIsTransparent = true;
  static const String? customStatusbarColor = null;

  static const String? initNavHeaderRadius = null;

  static const String defaultDepNoFormat = '[000] [00] [00000]';

  static const List<String> defaultAccountColor = ['#EEEEEE', '#FFFFFF'];

  static const String transactionAuth = 'PIN';
  static const int limitBackgroundTask = 5;

  static const bool pageComponentHasBackgroundImage = false;
  static const String overrideComponentBackgroundColor = 'transparent';

  static const String splashScreenType = 'default';
  static const int limitReConnectSocketIO = 30;
  //#endregion

  //login
  static const login = _Login();

  //register
  static const register = _Register();

  //pincode
  final pincode = _Pincode();

  //menu
  final menu = _Menu();

  //ผู้รับผลประโยชน์
  static const beneficiary = _Beneficiary();

  //ค้ำประกัน
  static const guarantee = _Guarantee();

  //เรียกเก็บ
  static const paymentMonthly = _PaymentMonthly();

  //แจ้งเตือน
  static const notification = _Notification();

  //เงินฝาก
  static const depositInfo = _DepositInfo();

  //statement เงินฝาก
  static const depositStatement = _DepositStatement();

  //ปันผล
  static const dividendInfo = _DividendInfo();

  //หุ้น
  static const shareInfo = _ShareInfo();

  //ข้อมูลสมาชิก
  static const memberInfo = _MemberInfo();

  //ประกัน
  static const insureInfo = _InsureInfo();

  //otp
  static const otp = _Otp();

  //setting
  static const setting = _Setting();

  //บัญชีโปรด
  static const favoriteAccount = _FavoriteAccount();

  //แลนดิ้ง
  static const landing = _Landing();

  //สลิป
  static const slipInfo = _SlipInfo();

  //ธุรกรรม
  static const transaction = _Transaction();
}

/* ========= Sub-Objects ========= */

class _Login {
  const _Login();

  final int maxPasswordAttempts = 6;
}

class _Register {
  const _Register();

  final bool disableRegister = false;
  final String disableTextNote = '';
  final bool requiredEmail = false;
  final bool verifyOtp = true;

  final String textOfTermsAndConditions = '''
  1. การเข้าใช้งานระบบข้อมูลสมาชิกจะต้องทำการสมัครเข้าใช้งานระบบและต้องเป็นสมาชิกของ สหกรณ์ออมทรัพย์ จำกัด เท่านั้น
  2. เพื่อความเรียบร้อยในการสมัครใช้งาน ระบบฯ และเพื่อยืนยันผู้สมัคร กรุณาทำตามขั้นตอนที่ระบบแนะนำ
  3. หากชื่อหรือหมายเลขสมาชิกของท่านได้มีการสมัครใช้งานแล้ว โดยท่านไม่ทราบ หรือทำการสมัครด้วยตัวท่านเองกรุณาแจ้งเจ้าหน้าที่เพื่อทำการตรวจสอบความถูกต้องต่อไป
  4. เพื่อความปลอดภัยในข้อมูลของท่าน หากสหกรณ์พบว่ามีบุคคลแอบอ้างใช้งานบัญชีของท่านในการเข้าสู่ระบบ สหกรณ์จะบังคับบุคคลนั้นออกจากระบบ โดยไม่ต้องแจ้งให้ทราบ
  5. หากข้อมูลรายละเอียดของสมาชิกไม่ถูกต้องในระบบ แล้วมีข้อสงสัยหรือต้องการทำการเปลี่ยนแปลงปรับปรุงข้อมูลให้สมาชิกติดต่อเจ้าหน้าที่เพื่อทำการแก้ไขปรับปรุงเปลี่ยนแปลงข้อมูลต่อไป
  6. ข้าพเจ้าได้อ่านข้อตกลงดังกล่าวและยินยอมในเงื่อนไขต่างๆที่ทางสหกรณ์ออมทรัพย์ จำกัด กำหนดไว้รวมทั้งที่สหกรณ์จะได้กำหนดเพิ่มเติมแก้ไข หรือเปลี่ยนแปลงในภายหน้า ซึ่งให้ถือเป็นส่วนหนึ่งของเงื่อนไขและข้อกำหนดนี้ด้วย
  ''';
}

class _Pincode {
  _Pincode();

  final List<String> circlePasswordColor = ['#9E9E9ECC', '#BDBDBDCC'];
  final int passwordLength = 6;
  final int maxAttempts = 6;
  final int timeLocked = 30000;
  final bool randomNumberPad = false;
  final String overrideBackgroundColor = 'transparent';
  final String pinImage = 'default';
}

class _Menu {
  _Menu();

  final List<int> menuHeaderId = [24, 42, 43];
  final List<int> menuExtraId = [1, 2];
}

class _Beneficiary {
  const _Beneficiary();
  final bool use_pdf = false;
}

class _Guarantee {
  const _Guarantee();
  final bool singleTab = false;
  final String defaultTab = 'YouCollWho';
}

class _PaymentMonthly {
  const _PaymentMonthly();
  final bool info_showPeriod = false;
  final bool detail_showPeriod = false;
}

class _Notification {
  const _Notification();
  final String page_defaultTab = 'news';
  final int initDataLimit = 10;
}

class _DepositInfo {
  const _DepositInfo();
  final String default_pattern_deptaccount_no = 'xxx-xx-xxxxx';
  final int maxLengthAliasName = 100;
}

class _DepositStatement {
  const _DepositStatement();
  final int maxLengthMemo = 140;
}

class _DividendInfo {
  const _DividendInfo();
}

class _ShareInfo {
  const _ShareInfo();
  final bool show_slip_no = true;
}

class _MemberInfo {
  const _MemberInfo();
  final bool show_signature = false;
}

class _InsureInfo {
  const _InsureInfo();
  final bool show_remark = false;
}

class _Otp {
  const _Otp();
  final bool enabled = true;
  final int passcodeLength = 6;
}

class _Setting {
  const _Setting();
  final bool setLargeFont = false;
}

class _FavoriteAccount {
  const _FavoriteAccount();
  final int favNameLength = 100;
}

class _Landing {
  const _Landing();

  final String footerBgColor = 'rgba(255,255,255,0.8)';
  final String footerIconColor = '#FFFFFF';
  final String footerIconBgColor = '#1976D2';
  final String contentBg = 'rgba(255,255,255,0.8)';
  final bool showCoopNameInHeader = true;
}

class _SlipInfo {
  const _SlipInfo();
  final bool show_slipno_onlist = false;
}

class _Transaction {
  const _Transaction();

  final int limitAddCoopAccount = 0;
  final int limitAddBindBankAccount = 0;
  final bool isEnableSwitchOnOffAccount = false;
  final String webHelpUrl = '';
}
