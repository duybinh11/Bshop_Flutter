import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProvinceVn {
  String name;
  int code;
  String codename;
  String divisionType;
  int phoneCode;
  List<Districts> districts;
  ProvinceVn({
    required this.name,
    required this.code,
    required this.codename,
    required this.divisionType,
    required this.phoneCode,
    required this.districts,
  });

  factory ProvinceVn.fromMap(Map<String, dynamic> map) {
    return ProvinceVn(
      name: map['name'] as String,
      code: map['code'] as int,
      codename: map['codename'] as String,
      divisionType: map['division_type'] as String,
      phoneCode: map['phone_code'] as int,
      districts: List<Districts>.from(
        (map['districts'] as List<dynamic>).map<Districts>(
          (x) => Districts.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() {
    return 'ProvinceVn(name: $name, code: $code, codename: $codename, divisionType: $divisionType, phoneCode: $phoneCode, )';
  }
}

class Districts {
  String name;
  int code;
  String codename;
  String divisionType;
  String shortCodename;
  List<Wards> wards;
  Districts({
    required this.name,
    required this.code,
    required this.codename,
    required this.divisionType,
    required this.shortCodename,
    required this.wards,
  });

  factory Districts.fromMap(Map<String, dynamic> map) {
    return Districts(
      name: map['name'] as String,
      code: map['code'] as int,
      codename: map['codename'] as String,
      divisionType: map['division_type'] as String,
      shortCodename: map['short_codename'] as String,
      wards: List<Wards>.from(
        (map['wards'] as List<dynamic>).map<Wards?>(
          (x) => Wards.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() {
    return 'Districts(name: $name, code: $code, codename: $codename, divisionType: $divisionType, shortCodename: $shortCodename)';
  }
}

class Wards {
  String name;
  int code;
  String codename;
  String divisionType;
  String shortCodename;
  Wards({
    required this.name,
    required this.code,
    required this.codename,
    required this.divisionType,
    required this.shortCodename,
  });

  factory Wards.fromMap(Map<String, dynamic> map) {
    return Wards(
      name: map['name'] as String,
      code: map['code'] as int,
      codename: map['codename'] as String,
      divisionType: map['division_type'] as String,
      shortCodename: map['short_codename'] as String,
    );
  }

  @override
  String toString() {
    return 'Wards(name: $name, code: $code, codename: $codename, divisionType: $divisionType, shortCodename: $shortCodename)';
  }
}
