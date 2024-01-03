import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StatusTransport {
  int id;
  String place;
  DateTime createdAt;
  StatusTransport({
    required this.id,
    required this.place,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'place': place,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory StatusTransport.fromMap(Map<String, dynamic> map) {
    return StatusTransport(
      id: map['id'] as int,
      place: map['place'] as String,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusTransport.fromJson(String source) =>
      StatusTransport.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'StatusTransport(id: $id, place: $place, createdAt: $createdAt)';
}
