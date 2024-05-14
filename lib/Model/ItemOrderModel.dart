// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:do_an2_1/Model/ItemModel.dart';
import 'package:do_an2_1/Model/StatusTransport.dart';

class ItemOrderModel extends ItemModel {
  int idOrder;
  int amount;
  int money;
  bool isShopConfirm;
  bool isRate;
  int? fls;
  List<StatusTransport> listStatusTransport;
  ItemOrderModel({
    required this.idOrder,
    required this.amount,
    required this.money,
    required this.isShopConfirm,
    required this.isRate,
    this.fls,
    required this.listStatusTransport,
    required super.id,
    required super.name,
    required super.price,
    required super.img,
    required super.descrip,
    required super.sold,
    required super.rateStar,
  });

  factory ItemOrderModel.fromMap(Map<String, dynamic> map) {
    ItemModel itemModel = ItemModel.fromMap(map['item']);
    print(map);
    return ItemOrderModel(
      idOrder: map['id'] as int,
      amount: map['amount'] as int,
      money: map['money'] as int,
      isShopConfirm: map['is_shop_confirm'] == 0 ? false : true,
      isRate: map['is_rate'] == 0 ? false : true,
      fls: map['fls_percent'] != null ? map['fls_percent'] as int : null,
      listStatusTransport: List<StatusTransport>.from(
        (map['status_transport'] as List<dynamic>).map<StatusTransport>(
          (x) => StatusTransport.fromMap(x as Map<String, dynamic>),
        ),
      ),
      id: itemModel.id,
      name: itemModel.name,
      price: itemModel.price,
      img: itemModel.img,
      descrip: itemModel.descrip,
      sold: itemModel.sold,
      rateStar: itemModel.rateStar,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemOrderModel.fromJson(String source) =>
      ItemOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemOrderModel(idOrder: $idOrder, amount: $amount, money: $money, isShopConfirm: $isShopConfirm, isRate: $isRate, fls: $fls, listStatusTransport: $listStatusTransport)';
  }

  @override
  bool operator ==(covariant ItemOrderModel other) {
    if (identical(this, other)) return true;

    return other.idOrder == idOrder &&
        other.amount == amount &&
        other.money == money &&
        other.isShopConfirm == isShopConfirm &&
        other.isRate == isRate &&
        other.fls == fls &&
        listEquals(other.listStatusTransport, listStatusTransport);
  }

  @override
  int get hashCode {
    return idOrder.hashCode ^
        amount.hashCode ^
        money.hashCode ^
        isShopConfirm.hashCode ^
        isRate.hashCode ^
        fls.hashCode ^
        listStatusTransport.hashCode;
  }
}
