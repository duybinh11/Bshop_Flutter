import 'dart:convert';

import 'package:do_an2_1/Model/ItemModel.dart';
import 'package:http/http.dart' as http;

class ApiItem {
  Future<List<ItemModel>> getItemFlashSale() async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/home/get_item_flash_sale');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> listData = jsonDecode(response.body)['data'];
      return listData.map((e) => ItemModel.fromMapFlashSale(e)).toList();
    }
    return [];
  }

  Future<List<ItemModel>> getItemByCategory(
      int page, int idCategory, int isDESC) async {
    Uri uri = Uri.parse(
        'http://10.0.2.2:8000/api/home/get_item_by_category/$idCategory/$isDESC?page=$page');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      List<dynamic> listData = map['data'];
      return listData.map((e) => ItemModel.fromMapByCategory(e)).toList();
    }
    return [];
  }

  Future<List<ItemModel>> searchItem(String name) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/home/search_item/$name');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> listData = jsonDecode(response.body);
      return listData.map((e) => ItemModel.fromMapByCategory(e)).toList();
    }
    return [];
  }
}
