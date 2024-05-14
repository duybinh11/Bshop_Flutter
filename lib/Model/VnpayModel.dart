import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VnpayModel {
  int id;
  int money;
  String BankCode;
  bool isPayment;
  DateTime createdAt;
  VnpayModel({
    required this.id,
    required this.money,
    required this.BankCode,
    required this.isPayment,
    required this.createdAt,
  });

  VnpayModel copyWith({
    int? id,
    int? money,
    String? BankCode,
    bool? isPayment,
    DateTime? createdAt,
  }) {
    return VnpayModel(
      id: id ?? this.id,
      money: money ?? this.money,
      BankCode: BankCode ?? this.BankCode,
      isPayment: isPayment ?? this.isPayment,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory VnpayModel.fromMap(Map<String, dynamic> map) {
    return VnpayModel(
      id: map['id'] as int,
      money: map['money'] as int,
      BankCode: map['bank_code'] as String,
      isPayment: map['is_payment'] as String == '1' ? true : false,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  @override
  String toString() {
    return 'VnpayModel(id: $id, money: $money, BankCode: $BankCode, isPayment: $isPayment, createdAt: $createdAt)';
  }
}
