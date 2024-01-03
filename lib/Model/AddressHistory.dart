import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressHistory {
  int id;
  String province;
  String district;
  String town;
  String placeDetail;
  AddressHistory({
    required this.id,
    required this.province,
    required this.district,
    required this.town,
    required this.placeDetail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'province': province,
      'district': district,
      'town': town,
      'place_detail': placeDetail,
    };
  }

  factory AddressHistory.fromMap(Map<String, dynamic> map) {
    return AddressHistory(
      id: map['id'] as int,
      province: map['province'] as String,
      district: map['district'] as String,
      town: map['town'] as String,
      placeDetail: map['place_detail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressHistory.fromJson(String source) =>
      AddressHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '$province,$district,$town, chi tiết: $placeDetail ';
  }
}
