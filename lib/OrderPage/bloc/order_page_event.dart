// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_page_bloc.dart';

abstract class OrderPageEvent {}

class EOrderPageGetOrder extends OrderPageEvent {
  int idUser;
  EOrderPageGetOrder({
    required this.idUser,
  });
}
