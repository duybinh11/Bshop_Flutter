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
  double rateStar;
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
      'rate_star': rateStar,
      'flash_sale': flashSaleModel?.toMap(),
    };
  }

  factory ItemModel.fromMapFlashSale(Map<String, dynamic> mapData) {
    Map mapItem = mapData['item'];
    Map? mapFlashSale = mapData['flash_sale'];
    return ItemModel(
      id: mapItem['id'] as int,
      name: mapItem['name'] as String,
      price: mapItem['price'] as int,
      img: mapItem['img'] as String,
      descrip: mapItem['descrip'] as String,
      sold: mapItem['sold'] as int,
      rateStar: double.parse(mapItem['rate_star'].toString()),
      flashSaleModel: mapFlashSale != null
          ? FlashSaleModel.fromMap(mapFlashSale as Map<String, dynamic>)
          : null,
    );
  }
  factory ItemModel.fromMapByCategory(Map<String, dynamic> map) {
    Map? mapFlashSale = map['flash_sale'];
    return ItemModel(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'] as int,
      img: map['img'] as String,
      descrip: map['descrip'] as String,
      sold: map['sold'] as int,
      rateStar: double.parse(map['rate_star'].toString()),
      flashSaleModel: mapFlashSale != null
          ? FlashSaleModel.fromMap(mapFlashSale as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMapFlashSale(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, price: $price, img: $img, descrip: $descrip, sold: $sold, rateStar: $rateStar, flashSaleModel: $flashSaleModel)';
  }
}
