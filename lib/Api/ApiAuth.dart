import 'dart:convert';

import 'package:do_an2_1/TokenManager.dart';
import 'package:http/http.dart' as http;

import '../Model/UserModel.dart';

class ApiAuth {
  Future<dynamic> login({required email, required password}) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/auth/login');
    http.Response response =
        await http.post(uri, body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      Map mapData = jsonDecode(response.body);
      if (mapData['status'] as bool) {
        TokenManager.setToken(mapData['access_token']);
        print(mapData['user']);
        final userModel = UserModel.fromMap(mapData['user']);

        return userModel;
      } else {
        return mapData['error'];
      }
    }
    return "loi";
  }

  static Future<dynamic> loginToken() async {
    String? token = await TokenManager.getToken();

    if (token != null) {
      Uri uri = Uri.parse('http://10.0.2.2:8000/api/auth/me');
      try {
        http.Response response = await http.post(
          uri,
          headers: {'Authorization': 'Bearer $token'},
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> mapData = jsonDecode(response.body);
          if (mapData['status'] as bool) {
            return UserModel.fromMap(mapData['user']);
          }
        }
      } catch (error) {
        print('Error calling API: $error');
      }
    }
    return false;
  }

  Future<dynamic> RegisterAccount(String email, String pass, String phone,
      String address, String username) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/auth/register');
    http.Response response = await http.post(uri, body: {
      'username': username,
      'email': email,
      'address': address,
      'phone': phone,
      'password': pass,
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> mapData = jsonDecode(response.body);
      if (mapData['status']) {
        return true;
      } else {
        return mapData['erorr'].toString();
      }
    }
    return false;
  }

  Future<UserModel?> getDataUser() async {
    String? token = await TokenManager.getToken();

    if (token != null) {
      Uri uri = Uri.parse('http://10.0.2.2:8000/api/auth/me');
      try {
        http.Response response = await http.post(
          uri,
          headers: {'Authorization': 'Bearer $token'},
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> mapData = jsonDecode(response.body);
          if (mapData['status'] as bool) {
            return UserModel.fromMap(mapData['user']);
          }
        }
      } catch (error) {
        print('Error calling API: $error');
      }
    }
    return null;
  }
}
