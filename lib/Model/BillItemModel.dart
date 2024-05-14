// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:do_an2_1/Model/AddressHistory.dart';
import 'package:do_an2_1/Model/ItemOrderModel.dart';

class BillItemModel {
  int id;
  AddressHistory address;
  int money;
  bool isPayment;
  bool isVnpay;
  List<ItemOrderModel> listOrder;
  DateTime createdAt;
  BillItemModel({
    required this.id,
    required this.address,
    required this.money,
    required this.isPayment,
    required this.isVnpay,
    required this.createdAt,
    required this.listOrder,
  });

  factory BillItemModel.fromMap(Map<String, dynamic> map) {
    return BillItemModel(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at']),
      address: AddressHistory.fromMap(
          map['address_receive'] as Map<String, dynamic>),
      money: map['price'] as int,
      isPayment: map['is_payment'] == 0 ? false : true,
      isVnpay: map['is_vnpay'] == 0 ? false : true,
      listOrder: List<ItemOrderModel>.from(
        (map['order'] as List<dynamic>).map<ItemOrderModel>(
          (x) => ItemOrderModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory BillItemModel.fromJson(String source) =>
      BillItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BillItemModel(id: $id, address: $address, money: $money, isPayment: $isPayment, isVnpay: $isVnpay, listOrder: $listOrder) createad = $createdAt';
  }
}
