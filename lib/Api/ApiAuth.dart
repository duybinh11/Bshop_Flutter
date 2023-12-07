import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/UserModel.dart';

class ApiAuth {
  Future<dynamic> login({required email, required password}) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/login');
    http.Response response =
        await http.post(uri, body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      Map mapData = jsonDecode(response.body);
      if (mapData['status'] as bool) {
        UserModel userModel = UserModel.fromMap(mapData['user']);
        setToken(userModel.token);
        return userModel;
      }
    }
    return false;
  }

  static Future<dynamic> loginToken() async {
    String? token = await getToken();
    if (token != null) {
      Uri uri = Uri.parse('http://10.0.2.2:8000/api/login/token');
      http.Response response = await http.post(uri, body: {'token': token});
      if (response.statusCode == 200) {
        Map<String, dynamic> mapData = jsonDecode(response.body);
        if (mapData['status'] as bool) {
          return UserModel.fromMap(mapData['user']);
        }
      }
    }
    return false;
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
