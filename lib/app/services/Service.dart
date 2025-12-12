import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'Config.dart';

final dio = Dio();

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = "https://proxy.thaicoop.co/DLACOOP/mobile_and_web-control";

  Future<Response> login(String username, String password) async {
    return await _dio.post(
      "$baseUrl/login",
      data: {
        "username": username,
        "password": password,
      },
    );
  }

  Future<Response> getUsers() async {
    return await _dio.get("$baseUrl/users");
  }
}

// class ApiService {
//   final Dio authenticate = Dio(BaseOptions(
//     baseUrl: AppConfig.authenticateUrl,
//     connectTimeout: Duration(milliseconds: AppConfig.timeoutService >= 0 ? AppConfig.timeoutService : 60000),
//   ));

//   final Dio api = Dio(BaseOptions(
//     baseUrl: AppConfig.mainApiUrl,
//     connectTimeout: Duration(milliseconds: AppConfig.timeoutService >= 0 ? AppConfig.timeoutService : 60000),
//   ));

//   final Dio apiBackup = Dio(BaseOptions(
//     baseUrl: firebaseConfigLocalValue().backupApi ?? AppConfig.backupApiUrl,
//     connectTimeout: Duration(milliseconds: AppConfig.timeoutService >= 0 ? AppConfig.timeoutService : 60000),
//   ));

//   // -------------------------------
//   // HttpService (เหมือน axios({...}))
//   // -------------------------------
//   Future<Map<String, dynamic>> httpService({
//     required String url,
//     String method = 'POST',
//     Map<String, dynamic>? data,
//     Map<String, dynamic>? headers,
//   }) async {
//     try {
//       final res = await Dio().request(
//         url,
//         data: data,
//         options: Options(method: method, headers: headers),
//       );

//       debugPrint("Response_HttpService $url => ${res.data}");

//       return {
//         ...res.data,
//         'httpStatus': res.statusCode,
//       };
//     } catch (e) {
//       debugPrint("Error_HttpService => $e");
//       return {'httpStatus': 500};
//     }
//   }

//   // -------------------------------
//   // AuthenticateProvider
//   // -------------------------------
//   Future<dynamic> authenticateProvider(String url, Map data) async {
//     try {
//       final res = await authenticate.post(url, data: data);

//       debugPrint("Response_AuthenticateProvider $url => ${res.data}");

//       return res.data;
//     } catch (e) {
//       debugPrint("Error_AuthenticateProvider $url => $e");

//       if (e is DioException && e.response != null) {
//         return e.response;
//       }

//       return false;
//     }
//   }

//   // -------------------------------
//   // ServiceProvider (เวอร์ชัน Flutter)
//   // -------------------------------
//   Future<Map<String, dynamic>> serviceProvider(
//     String url, {
//     Map<String, dynamic>? data,
//     Map<String, dynamic>? headers,
//     bool noneAuth = false,
//     String? responseType,
//     String method = "POST",
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     final deviceInfo = DeviceInfoPlugin();

//     final accessToken = prefs.getString("ACCESS_TOKEN") ?? '';
//     final refreshToken = prefs.getString("REFRESH_TOKEN");

//     final h = {
//       "Authorization": "Bearer ${noneAuth ? '' : accessToken}",
//       "Lang_locale": "th",
//       ...?headers,
//     };

//     final body = {
//       "channel": "mobile_app",
//       "app_version": "1.0.0",
//       "refresh_token": refreshToken,
//       "unique_id": (await deviceInfo.deviceInfo).data["identifierForVendor"] ?? "",
//       "ip_address": "0.0.0.0", // ไม่มี getCurrentIPAddress ใน Flutter
//       ...?data,
//     };

//     Response? res;

//     // ------------------------------------
//     // ยิง API หลัก (main API)
//     // ------------------------------------
//     try {
//       res = await api.request(
//         url,
//         data: body,
//         options: Options(method: method, headers: h),
//       );

//       debugPrint("Response_MainServiceProvider $url => ${res.data}");
//     } catch (e) {
//       debugPrint("Error_MainServiceProvider $url => $e");

//       if (e is DioException) {
//         if (catchEventForServiceProvider(e.response)) {
//           return {"data": e.response?.data, "httpStatus": 204};
//         }

//         if (e.response != null) {
//           res = e.response;
//         } else {
//           // ไม่มี response → offline หรือ server down
//           return await _callBackupApi(url, body, h, method);
//         }
//       }
//     }

//     if (res == null) {
//       return await _callBackupApi(url, body, h, method);
//     }

//     // Save NEW_TOKEN (เหมือน JS)
//     if (res.data["NEW_TOKEN"] != null) {
//       await prefs.setString('ACCESS_TOKEN', res.data["NEW_TOKEN"]);
//       res.data.remove("NEW_TOKEN");
//     }

//     if (responseType == "plainText") {
//       return {"data": res.data, "httpStatus": res.statusCode};
//     }

//     return {
//       ...res.data,
//       "httpStatus": res.statusCode,
//     };
//   }

//   // --------------------------------
//   // backup API
//   // --------------------------------
//   Future<Map<String, dynamic>> _callBackupApi(
//     String url,
//     Map body,
//     Map headers,
//     String method,
//   ) async {
//     try {
//       final res = await apiBackup.request(
//         url,
//         data: body,
//         options: Options(method: method, headers: headers),
//       );

//       debugPrint("Response_BackupServiceProvider $url => ${res.data}");

//       return {
//         ...res.data,
//         'httpStatus': res.statusCode,
//       };
//     } catch (e) {
//       debugPrint("Error_BackupServiceProvider => $e");

//       if (e is DioException && e.response != null) {
//         if (catchEventForServiceProvider(e.response)) {
//           return {"data": e.response?.data, "httpStatus": 204};
//         }

//         return {
//           ...e.response!.data,
//           "httpStatus": e.response!.statusCode,
//         };
//       }

//       return {"httpStatus": 0};
//     }
//   }

//   // --------------------------------
//   // catchEventForServiceProvider
//   // --------------------------------
//   bool catchEventForServiceProvider(Response? response) {
//     if (response == null) return false;

//     final data = response.data;
//     final status = response.statusCode;

//     if (status == 401) {
//       if (data != null && data["RESPONSE_CODE"] != null) {
//         debugPrint("${data["RESPONSE_CODE"]} : ${data["RESPONSE_MESSAGE"]}");
//       }
//       return true;
//     }
//     return false;
//   }
// }

