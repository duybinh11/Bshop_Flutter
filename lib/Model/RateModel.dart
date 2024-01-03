import 'dart:convert';

import 'UserModel.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RateModel {
  int id;
  double rateStar;
  String comment;
  UserModel userModel;
  DateTime createdAt;
  RateModel({
    required this.id,
    required this.rateStar,
    required this.comment,
    required this.userModel,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rate_star': rateStar,
      'comment': comment,
      'user': userModel.toMap(),
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory RateModel.fromMap(Map<String, dynamic> map) {
    return RateModel(
      id: map['id'] as int,
      rateStar: double.parse(map['rate_star'].toString()),
      comment: map['comment'] as String,
      userModel: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RateModel.fromJson(String source) =>
      RateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
