import 'dart:convert';

import 'package:do_an2_1/Model/BillItemModel.dart';
import 'package:do_an2_1/Model/ItemModel.dart';
import 'package:do_an2_1/Model/RateModel.dart';
import 'package:do_an2_1/Model/StatusTransport.dart';
import 'package:do_an2_1/TokenManager.dart';
import 'package:http/http.dart' as http;

import '../Model/AddressHistory.dart';
import '../Model/ItemCartModel.dart';
import '../Model/ShopModel.dart';

class ApiItem {
  Future<List<ItemModel>> getItemFlashSale() async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/home/get_item_flash_sale');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> listData = jsonDecode(response.body)['data'];
      return listData.map((e) => ItemModel.fromMap(e)).toList();
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
      return listData.map((e) => ItemModel.fromMap(e)).toList();
    }

    return [];
  }

  Future<List<ItemModel>> searchItem(
      String name, int idCategory, int isASC, int page) async {
    Uri uri = Uri.parse(
        'http://10.0.2.2:8000/api/home/search_item/$name/$idCategory/$isASC?page=$page');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> listData = jsonDecode(response.body)['data'];
      return listData.map((e) => ItemModel.fromMap(e)).toList();
    }
    return [];
  }

  Future<dynamic> getItemDetail(int idItem) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/item_detail/$idItem');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> mapData = jsonDecode(response.body);
      return ItemModel.fromMap(mapData);
    }
    return false;
  }

  Future<ShopModel?> getShop(int idItem) async {
    Uri uri =
        Uri.parse('http://10.0.2.2:8000/api/item_detail/get_shop/$idItem');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return ShopModel.fromMap(map);
    }
    return null;
  }

  Future<List<RateModel>> getRate(
    int idItem,
  ) async {
    Uri uri =
        Uri.parse('http://10.0.2.2:8000/api/item_detail/get_rate/$idItem');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> listData = jsonDecode(response.body);
      print(listData);
      return listData.map((e) => RateModel.fromMap(e)).toList();
    }
    return [];
  }

  Future<bool> addCart(int idItem, int amount) async {
    String? token = await TokenManager.getToken();
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/item_detail/add_cart');
    http.Response response = await http.post(
      uri,
      body: {'id_item': idItem.toString(), 'amount': amount.toString()},
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<ItemCartModel>> getAllCart() async {
    String? token = await TokenManager.getToken();
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/cart/get_all_cart');
    http.Response response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      List<dynamic> listData = jsonDecode(response.body);
      print(listData);
      return listData.map((e) => ItemCartModel.fromMap(e)).toList();
    }
    return [];
  }

  Future<bool> deleteCart(int idCart) async {
    String? token = await TokenManager.getToken();
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/cart/delete_cart/$idCart');
    http.Response response =
        await http.delete(uri, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'] as bool;
    }
    return false;
  }

  Future<void> changeAmount(int idCart, bool isTang) async {
    int isTangI = isTang ? 1 : 0;
    String? token = await TokenManager.getToken();
    Uri uri = Uri.parse(
        'http://10.0.2.2:8000/api/cart/change_amount/$idCart/$isTangI');
    http.Response response =
        await http.put(uri, headers: {'Authorization': 'Bearer $token'});
  }

  Future<AddressHistory?> getAddressDefault() async {
    String? token = await TokenManager.getToken();
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/order/address_default');
    http.Response response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      Map<String, dynamic>? mapData = jsonDecode(response.body)['default'];
      return mapData != null ? AddressHistory.fromMap(mapData) : null;
    }
    return null;
  }

  Future<bool> addAdress(
      {required String province,
      required String district,
      required String ward,
      required bool isDefault,
      required String placeDetail}) async {
    String? token = await TokenManager.getToken();
    int isDefaultI = isDefault ? 1 : 0;
    Uri uri = Uri.parse(
        'http://10.0.2.2:8000/api/order/add_address_history/$province/$district/$ward/$isDefaultI/$placeDetail');
    http.Response response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> mapData = jsonDecode(response.body);

      return mapData['status'];
    }
    return false;
  }

  Future<List<AddressHistory>> getAddressHistory() async {
    String? token = await TokenManager.getToken();
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/order/get_address_history');
    http.Response response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      List<dynamic> listData = jsonDecode(response.body)['address'];
      return listData.isEmpty
          ? []
          : listData.map((e) => AddressHistory.fromMap(e)).toList();
    }
    return [];
  }

  Future<void> setAddressHistory(int idAddress) async {
    String? token = await TokenManager.getToken();
    Uri uri = Uri.parse(
        'http://10.0.2.2:8000/api/order/set_address_default/$idAddress');
    // ignore: unused_local_variable
    http.Response response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
  }

  Future<Map<String, dynamic>> addBill({
    required List<ItemCartModel> listCart,
    required int idAdress,
    required int money,
    required int isVnpay,
  }) async {
    String? token = await TokenManager.getToken();
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/order/add_bill');
    String listJson = jsonEncode(listCart.map((e) => e.toJson()).toList());
    http.Response response = await http.post(uri, body: {
      'list_json': listJson,
      'id_address': idAdress.toString(),
      'money': money.toString(),
      'is_vnpay': isVnpay.toString()
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return <String, dynamic>{'status': false};
  }

  Future<Map<String, dynamic>> getOrderWaiting() async {
    String? token = await TokenManager.getToken();
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/order/get_order_all');
    http.Response response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return <String, dynamic>{'status': false};
  }

  Future<bool> rateAddItem(
      {required int idOrder,
      required String comment,
      required double rate,
      required int idItem}) async {
    String? token = await TokenManager.getToken();
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/rate_item/add_rate_item');
    http.Response response = await http.post(uri, body: {
      'id_order': idOrder.toString(),
      'id_item': idItem.toString(),
      'comment': comment,
      'rate_num': rate.toString(),
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'] as bool;
    }
    return false;
  }

  Future<StatusTransport?> updateReceived({
    required int idOrder,
  }) async {
    String? token = await TokenManager.getToken();
    Uri uri =
        Uri.parse('http://10.0.2.2:8000/api/order/update_received/$idOrder');
    http.Response response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> mapData = jsonDecode(response.body);
      if (mapData['status']) {
        return StatusTransport.fromMap(mapData['status_address']);
      }
      return null;
    }
    return null;
  }

  Future<BillItemModel?> getBillRefresh({required int idBill}) async {
    String? token = await TokenManager.getToken();
    Uri uri =
        Uri.parse('http://10.0.2.2:8000/api/order/get_bill_refresh/$idBill');
    http.Response response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      print(response.statusCode);
      Map<String, dynamic> mapData = jsonDecode(response.body);
      if (mapData['bill'] != null) {
        return BillItemModel.fromMap(mapData['bill']);
      }
    }
    return null;
  }
}
