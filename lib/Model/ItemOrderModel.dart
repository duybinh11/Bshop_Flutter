// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:do_an2_1/Model/ItemModel.dart';
import 'package:do_an2_1/Model/StatusTransport.dart';

class ItemOrderModel {
  int id;
  ItemModel item;
  int amount;
  int money;
  bool isShopConfirm;
  bool isRate;
  int? fls;
  List<StatusTransport> listStatusTransport;
  ItemOrderModel({
    required this.id,
    required this.item,
    required this.amount,
    required this.money,
    required this.isShopConfirm,
    required this.isRate,
    this.fls,
    required this.listStatusTransport,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'item': item.toMap(),
      'amount': amount,
      'money': money,
      'is_shop_confirm': isShopConfirm,
      'is_rate': isRate,
      'fls': fls,
      'status_transport': listStatusTransport.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemOrderModel.fromMap(Map<String, dynamic> map) {
    return ItemOrderModel(
      id: map['id'] as int,
      item: ItemModel.fromMapOrder(map['item'] as Map<String, dynamic>),
      amount: map['amount'] as int,
      money: map['money'] as int,
      isShopConfirm: map['is_shop_confirm'] == 0 ? false : true,
      isRate: map['is_rate'] == 0 ? false : true,
      fls: map['fls'] != null ? map['fls'] as int : null,
      listStatusTransport: List<StatusTransport>.from(
        (map['status_transport'] as List<dynamic>).map<StatusTransport>(
          (x) => StatusTransport.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemOrderModel.fromJson(String source) =>
      ItemOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemOrderModel(id: $id, item: $item, amount: $amount, money: $money, isShopConfirm: $isShopConfirm, fls: $fls, listStatusTransport: $listStatusTransport ,is_rate $isRate)';
  }

  ItemOrderModel copyWith({
    int? id,
    ItemModel? item,
    int? amount,
    int? money,
    bool? isShopConfirm,
    bool? isRate,
    int? fls,
    List<StatusTransport>? listStatusTransport,
  }) {
    return ItemOrderModel(
      id: id ?? this.id,
      item: item ?? this.item,
      amount: amount ?? this.amount,
      money: money ?? this.money,
      isShopConfirm: isShopConfirm ?? this.isShopConfirm,
      isRate: isRate ?? this.isRate,
      fls: fls ?? this.fls,
      listStatusTransport: listStatusTransport ?? this.listStatusTransport,
    );
  }
}
