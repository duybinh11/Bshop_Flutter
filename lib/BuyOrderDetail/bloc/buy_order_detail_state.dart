// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'buy_order_detail_bloc.dart';

@immutable
sealed class BuyOrderDetailState {}

final class BuyOrderDetailInitial extends BuyOrderDetailState {}

final class SBuyOrderDetailLoading extends BuyOrderDetailState {}

final class SBuyOrderDetailBillLoading extends BuyOrderDetailState {}

// ignore: must_be_immutable
final class SBuyOrderDetailBillRefreshSuccess extends BuyOrderDetailState {
  BillItemModel billItemModel;
  SBuyOrderDetailBillRefreshSuccess({required this.billItemModel});
}

final class SBuyOrderDetailRated extends BuyOrderDetailState {}

// ignore: must_be_immutable
class SBuyOrderDetaiReceivedSuccess extends BuyOrderDetailState {
  StatusTransport statusAddress;
  int idOrder;
  SBuyOrderDetaiReceivedSuccess(
      {required this.statusAddress, required this.idOrder});
}
