// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vn_pay_bloc.dart';

abstract class VnPayEvent {}

class EVnpayGetUrl extends VnPayEvent {
  int money;
  EVnpayGetUrl({
    required this.money,
  });
}

class EVnPayAddVnpay extends VnPayEvent {
  int id;
  int money;
  String bankCode;
  int isPayMent;
  EVnPayAddVnpay({
    required this.id,
    required this.money,
    required this.bankCode,
    required this.isPayMent,
  });
}

class EVnPayAddVnpayBuyItem extends VnPayEvent {
  OrderDetailBloc orderDetailBloc;
  EVnPayAddVnpayBuyItem({required this.orderDetailBloc});
}

class EVnpayUpdateBill extends VnPayEvent {}
