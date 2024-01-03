// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartState {}

final class CartInitial extends CartState {}

final class SCartLoading extends CartState {}

final class SCartEmpty extends CartState {}

class SCartAllCart extends CartState {
  List<ItemCartModel> listCart;
  SCartAllCart({
    required this.listCart,
  });
}

class SCartDeleteErorr extends CartState {
  String erorr;
  SCartDeleteErorr({
    required this.erorr,
  });
}

class SCartMoneyCart extends CartState {
  int money;
  SCartMoneyCart({
    required this.money,
  });
}
