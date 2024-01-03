import 'dart:convert';

import 'package:do_an2_1/Model/ProvinceVn.dart';
import 'package:http/http.dart' as http;

class ApiProvince {
  Future<List<ProvinceVn>> getProvince() async {
    Uri uri = Uri.parse('https://provinces.open-api.vn/api/?depth=3');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> listData = jsonDecode(utf8.decode(response.bodyBytes));
      return listData.map((e) => ProvinceVn.fromMap(e)).toList();
    }
    return [];
  }


}
