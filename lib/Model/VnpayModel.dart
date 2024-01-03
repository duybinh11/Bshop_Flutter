import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VnpayModel {
  int id;
  int money;
  DateTime createdAt;
  VnpayModel({
    required this.id,
    required this.money,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'money': money,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory VnpayModel.fromMap(Map<String, dynamic> map) {
    return VnpayModel(
      id: map['id'] as int,
      money: map['money'] as int,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory VnpayModel.fromJson(String source) =>
      VnpayModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
