import 'package:sko_flutter/app/services/Service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String mainApiUrl = "https://proxy.thaicoop.co/DLACOOP/mobile_and_web-control";

  Future<Map<String, dynamic>> fetchUser(String userId) async {
    final url = Uri.parse("$mainApiUrl/user/$userId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load user");
    }
  }
}