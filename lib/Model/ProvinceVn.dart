import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProvinceVn {
  String id;
  String name;
  ProvinceVn({
    required this.id,
    required this.name,
  });

  ProvinceVn copyWith({
    String? id,
    String? name,
  }) {
    return ProvinceVn(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idProvince': id,
      'name': name,
    };
  }

  factory ProvinceVn.fromMap(Map<String, dynamic> map) {
    return ProvinceVn(
      id: map['idProvince'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProvinceVn.fromJson(String source) =>
      ProvinceVn.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProvinceVn(id: $id, name: $name)';
}

class Districts {
  String idProvince;
  String idDistrict;
  String name;
  Districts({
    required this.idProvince,
    required this.idDistrict,
    required this.name,
  });

  factory Districts.fromMap(Map<String, dynamic> map) {
    return Districts(
      idProvince: map['idProvince'] as String,
      idDistrict: map['idDistrict'] as String,
      name: map['name'] as String,
    );
  }

  factory Districts.fromJson(String source) =>
      Districts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Districts(idProvince: $idProvince, idDistrict: $idDistrict, name: $name)';
}

class Wards {
  String idDistrict;
  String idCommune;
  String name;
  Wards({
    required this.idDistrict,
    required this.idCommune,
    required this.name,
  });

 
  factory Wards.fromMap(Map<String, dynamic> map) {
    return Wards(
      idDistrict: map['idDistrict'] as String,
      idCommune: map['idCommune'] as String,
      name: map['name'] as String,
    );
  }

  
  @override
  String toString() => 'Wards(idDistrict: $idDistrict, idCommune: $idCommune, name: $name)';

 
}
