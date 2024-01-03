// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'buy_order_detail_bloc.dart';

@immutable
sealed class BuyOrderDetailEvent {}

// ignore: must_be_immutable
class EBuyOrderDetailGetVnpay extends BuyOrderDetailEvent {
  int idBill;
  EBuyOrderDetailGetVnpay({
    required this.idBill,
  });
}

// ignore: must_be_immutable
class EBuyOrderDetailReset extends BuyOrderDetailEvent {}

// ignore: must_be_immutable
class EBuyOrderDetailUpdateReceived extends BuyOrderDetailEvent {
  int idOrder;
  EBuyOrderDetailUpdateReceived({
    required this.idOrder,
  });
}
