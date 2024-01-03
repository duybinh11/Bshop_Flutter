import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: file_names
class ShopModel {
  int id;
  String username;
  String phone;
  String email;
  String descrip;
  String address;
  String img;
  int follower;
  DateTime createAt;

  ShopModel({
    required this.id,
    required this.follower,
    required this.username,
    required this.phone,
    required this.email,
    required this.descrip,
    required this.img,
    required this.address,
    required this.createAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'follower': follower,
      'phone': phone,
      'email': email,
      'descrip': descrip,
      'img': img,
      'address': address,
      'create_at': createAt.millisecondsSinceEpoch,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      id: map['id'] as int,
      username: map['username'] as String,
      phone: map['phone'] as String,
      follower: map['follower'],
      img: map['img'],
      email: map['email'] as String,
      descrip: map['descrip'] as String,
      address: map['address'] as String,
      createAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) =>
      ShopModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
