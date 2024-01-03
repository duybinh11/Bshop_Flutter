import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FlashSaleModel {
  int id;
  int percent;
  DateTime timeStart;
  DateTime timeEnd;
  FlashSaleModel({
    required this.id,
    required this.percent,
    required this.timeStart,
    required this.timeEnd,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'percent': percent,
      'time_start': timeStart.toIso8601String(),
      'time_end': timeEnd.toIso8601String(),
    };
  }

  factory FlashSaleModel.fromMap(Map<String, dynamic> map) {
    return FlashSaleModel(
      id: map['id'] as int,
      percent: map['percent'] as int,
      timeStart: DateTime.parse(map['time_start'] as String),
      timeEnd: DateTime.parse(map['time_end'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlashSaleModel.fromJson(String source) =>
      FlashSaleModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
