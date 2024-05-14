// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:do_an2_1/Model/ItemModel.dart';

class ItemCartModel extends ItemModel {
  int idCart;
  int amount;
  DateTime createdAt;

  ItemCartModel({
    required this.idCart,
    required super.id,
    required super.name,
    required super.price,
    required super.img,
    required super.descrip,
    required super.sold,
    required super.flashSaleModel,
    required super.rateStar,
    required this.amount,
    required this.createdAt,
  });
  Map<String, dynamic> toEncodableMap() {
    Map<String, dynamic> mapItem = super.toMap();
    mapItem['amount'] = amount;
    mapItem['created_at'] = createdAt.toIso8601String();
    mapItem['id'] = idCart;
    return mapItem;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapItem = super.toMap();
    mapItem['amount'] = amount;
    mapItem['created_at'] = createdAt.toIso8601String();
    mapItem['id_cart'] = idCart;
    return mapItem;
  }

  factory ItemCartModel.fromMap(Map<String, dynamic> map) {
    ItemModel itemModel = ItemModel.fromMap(map['item']);
    return ItemCartModel(
        idCart: map['id'],
        amount: map['amount'] as int,
        createdAt: DateTime.parse(map['created_at']),
        id: itemModel.id,
        descrip: itemModel.descrip,
        img: itemModel.img,
        name: itemModel.name,
        price: itemModel.price,
        rateStar: itemModel.rateStar,
        flashSaleModel: itemModel.flashSaleModel,
        sold: itemModel.sold);
  }

  @override
  String toJson() => json.encode(toMap());

  factory ItemCartModel.fromJson(String source) =>
      ItemCartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
