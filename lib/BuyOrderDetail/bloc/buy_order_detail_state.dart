// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'buy_order_detail_bloc.dart';

@immutable
sealed class BuyOrderDetailState {}

final class BuyOrderDetailInitial extends BuyOrderDetailState {}

final class SBuyOrderDetailLoading extends BuyOrderDetailState {}

final class SBuyOrderDetailReset extends BuyOrderDetailState {}

// ignore: must_be_immutable
class SBuyOrderDetaiVNpay extends BuyOrderDetailState {
  VnpayModel vnpayModel;
  SBuyOrderDetaiVNpay({
    required this.vnpayModel,
  });
}

// ignore: must_be_immutable
class SBuyOrderDetaiReceivedSuccess extends BuyOrderDetailState {
  StatusTransport statusAddress;
  int idOrder;
  SBuyOrderDetaiReceivedSuccess(
      {required this.statusAddress, required this.idOrder});
}
