import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int id;
  String email;
  String username;
  String phone;
  String address;
  String token;
  String? img;
  UserModel(
      {required this.id,
      required this.email,
      required this.username,
      required this.phone,
      required this.address,
      required this.img,
      required this.token});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
      'phone': phone,
      'address': address,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      email: map['email'] as String,
      img: map['img'] != null ? map['img'] as String : null,
      username: map['username'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
