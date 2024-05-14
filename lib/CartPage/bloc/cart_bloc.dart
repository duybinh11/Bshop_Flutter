import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_an2_1/Api/ApiItem.dart';
import 'package:do_an2_1/Model/ItemCartModel.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<ItemCartModel> listCartSelected = [];
  int money = 0;
  ApiItem apiItem = ApiItem();
  CartBloc() : super(CartInitial()) {
    on<ECartGetallCart>(getAllCart);
    on<ECartChangeSl>(changeAmount);
    on<ECartDelete>(deleteCart);
    on<ECartAddOrder>(addOrder);
  }

  FutureOr<void> getAllCart(
      ECartGetallCart event, Emitter<CartState> emit) async {
    listCartSelected.clear();
    emit(SCartLoading());
    List<ItemCartModel> listCart = await apiItem.getAllCart();
    listCart.isEmpty
        ? emit(SCartEmpty())
        : emit(SCartAllCart(listCart: listCart));
  }

  FutureOr<void> changeAmount(
      ECartChangeSl event, Emitter<CartState> emit) async {
    ItemCartModel cartModel = event.itemCartModel;
    apiItem.changeAmount(cartModel.idCart, event.isTang);
    if (event.isTang && listCartSelected.contains(cartModel)) {
      money += totalAItemCart(cartModel: cartModel, amount: 1);
      emit(SCartMoneyCart(money: money));
    } else if (!event.isTang &&
        listCartSelected.contains(event.itemCartModel)) {
      money -= totalAItemCart(cartModel: cartModel, amount: 1);
      emit(SCartMoneyCart(money: money));
    }
  }

  FutureOr<void> deleteCart(ECartDelete event, Emitter<CartState> emit) async {
    emit(SCartLoading());
    bool check = await apiItem.deleteCart(event.idCart);
    if (check) {
      List<ItemCartModel> listCart = await apiItem.getAllCart();
      if (listCart.isNotEmpty) {
        listCartSelected.clear();
        emit(SCartAllCart(listCart: listCart));
      } else {
        emit(SCartEmpty());
      }
    }
  }

  FutureOr<void> addOrder(ECartAddOrder event, Emitter<CartState> emit) {
    money = 0;
    if (event.isAdd) {
      listCartSelected.add(event.itemCartModel);
    } else {
      listCartSelected
          .removeWhere((element) => element.id == event.itemCartModel.id);
    }
    for (var element in listCartSelected) {
      money += totalAItemCart(cartModel: element, amount: element.amount);
    }
    emit(SCartMoneyCart(money: money));
  }

  int totalAItemCart({required ItemCartModel cartModel, required int amount}) {
    if (cartModel.flashSaleModel != null) {
      return (amount *
              cartModel.price *
              (1 - cartModel.flashSaleModel!.percent / 100))
          .toInt();
    } else {
      return amount * cartModel.price;
    }
  }
}
