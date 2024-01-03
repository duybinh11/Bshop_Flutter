// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vn_pay_bloc.dart';

abstract class VnPayState {}

final class VnPayInitial extends VnPayState {}

final class SVnPayLoading extends VnPayState {}

final class SVnPayGetUrlErorr extends VnPayState {}

class SVnpayGetUrlSuccesss extends VnPayState {
  String url;
  SVnpayGetUrlSuccesss({
    required this.url,
  });
}
final class SVnPayPaymentSuccess extends VnPayState {}
final class SVnPayPaymentNotPay extends VnPayState {}
final class SVnPayPaymentErorr extends VnPayState {}
