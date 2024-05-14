import 'dart:convert';

import 'package:do_an2_1/Model/VnpayModel.dart';
import 'package:http/http.dart' as http;

class ApiVnpay {
  Future<Map<String, dynamic>> getUrl(int money) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/vnpay/get_url');
    http.Response response =
        await http.post(uri, body: {'money': money.toString()});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return <String, dynamic>{'status': false};
  }

  Future<bool> addVnpay(
      {required int idBill,
      required int idBanking,
      required String bankCode,
      required int money,
      required int isPayment}) async {
    Uri uri = Uri.parse(
        'http://10.0.2.2:8000/api/vnpay/add_vnpay/$idBill/$idBanking/$bankCode/$money/$isPayment');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'];
    }
    return false;
  }

  Future<void> updateBill(int idBill) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/vnpay/update_bill');
    // ignore: unused_local_variable
    http.Response response =
        await http.put(uri, body: {'id_bill': idBill.toString()});
  }

  Future<VnpayModel?> getVnpay(int idBill) async {
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/vnpay/get_vnpay/$idBill');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> mapData = jsonDecode(response.body);
      return VnpayModel.fromMap(mapData);
    }
    return null;
  }
}
