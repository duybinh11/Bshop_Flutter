// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_page_bloc.dart';

abstract class OrderPageState {}

final class OrderPageInitial extends OrderPageState {}

final class SOrderPagGetOrderLoading extends OrderPageState {}

final class SOrderPageErorr extends OrderPageState {}

final class SOrderPageGetOrderEmpty extends OrderPageState {}

class SOrderPageOrderGetOrder extends OrderPageState {
  List<BillItemModel> listBill;
  SOrderPageOrderGetOrder({
    required this.listBill,
  });
}
