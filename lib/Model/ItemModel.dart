// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:do_an2_1/Model/FlashSaleModel.dart';

class ItemModel {
  int id;
  String name;
  int price;
  String img;
  String descrip;
  int sold;
  double? rateStar;
  FlashSaleModel? flashSaleModel;
  ItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.img,
    required this.descrip,
    required this.sold,
    required this.rateStar,
    this.flashSaleModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'img': img,
      'descrip': descrip,
      'sold': sold,
      'rate_avg': rateStar,
      'flash_sale': flashSaleModel?.toMap(),
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> mapData) {
    Map? mapFlashSale = mapData['flash_sale'];
    return ItemModel(
      id: mapData['id'] as int,
      name: mapData['name'] as String,
      price: mapData['price'] as int,
      img: mapData['img'] as String,
      descrip: mapData['descrip'] as String,
      sold: mapData['sold'] as int,
      rateStar: mapData['rate_avg'] != null
          ? double.parse(mapData['rate_avg'].toString())
          : null,
      flashSaleModel: mapFlashSale != null
          ? FlashSaleModel.fromMap(mapFlashSale as Map<String, dynamic>)
          : null,
    );
  }

  factory ItemModel.fromMapOrder(Map<String, dynamic> mapData) {
    return ItemModel(
        id: mapData['id'] as int,
        name: mapData['name'] as String,
        price: mapData['price'] as int,
        img: mapData['img'] as String,
        descrip: mapData['descrip'] as String,
        sold: mapData['sold'] as int,
        rateStar: 0.0,
        flashSaleModel: null);
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, price: $price, img: $img, descrip: $descrip, sold: $sold, rateStar: $rateStar, flashSaleModel: $flashSaleModel)';
  }
}
