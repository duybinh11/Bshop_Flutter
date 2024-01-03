// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartEvent {}

class ECartGetallCart extends CartEvent {
  int idUser;
  ECartGetallCart({
    required this.idUser,
  });
}

class ECartChangeSl extends CartEvent {
  ItemCartModel itemCartModel;
  bool isTang;
  ECartChangeSl({
    required this.itemCartModel,
    required this.isTang,
  });
}

class ECartDelete extends CartEvent {
  int idCart;
  int idUser;
  ECartDelete({required this.idCart, required this.idUser});
}

class ECartAddOrder extends CartEvent {
  ItemCartModel itemCartModel;
  bool isAdd;
  ECartAddOrder({
    required this.itemCartModel,
    required this.isAdd,
  });
}
