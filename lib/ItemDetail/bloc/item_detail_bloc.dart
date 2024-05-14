import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_an2_1/Api/ApiItem.dart';
import 'package:do_an2_1/Model/AddressHistory.dart';
import 'package:do_an2_1/Model/ItemModel.dart';
import 'package:do_an2_1/Model/RateModel.dart';
import 'package:do_an2_1/Model/ShopModel.dart';

part 'item_detail_event.dart';
part 'item_detail_state.dart';

class ItemDetailBloc extends Bloc<ItemDetailEvent, ItemDetailState> {
  ApiItem apiItem = ApiItem();
  int count = 1;
  String namePay = 'Thanh Toán sau khi nhận hàng';
  void clearBloc() {
    count = 1;
    namePay = 'Thanh Toán sau khi nhận hàng';
  }

  ItemDetailBloc() : super(ItemDetailInitial()) {
    on<EItemDetailGetData>(itemDetailGetData);
    on<EItemDetailUpdateCount>(setCount);
    on<EItemDetailRate>(getRateItem);
    on<EItemDetailAddCart>(addCart);
    // on<EItemDetailGetAddressDefault>(getAddressDefault);
  }

  FutureOr<void> itemDetailGetData(
      EItemDetailGetData event, Emitter<ItemDetailState> emit) async {
    emit(SItemDetailLoading());
    List<dynamic> result = await Future.wait(
        [apiItem.getItemDetail(event.id), apiItem.getShop(event.id)]);
    ItemModel item = result[0];
    ShopModel shopModel = result[1];
    emit(SItemDetailGetData(item: item, shopModel: shopModel));
  }

  FutureOr<void> setCount(
      EItemDetailUpdateCount event, Emitter<ItemDetailState> emit) async {
    count = event.count;
  }

  FutureOr<void> getRateItem(
      EItemDetailRate event, Emitter<ItemDetailState> emit) async {
    emit(SItemDetailLoadingRate());
    List<RateModel> listRate = await apiItem.getRate(event.id);
    listRate.isEmpty
        ? emit(SItemDetailRateEmpty())
        : emit(SItemDetailGetRate(listRate: listRate));
  }

  FutureOr<void> addCart(
      EItemDetailAddCart event, Emitter<ItemDetailState> emit) async {
    emit(SItemDetailAddCartLoading());
    bool result = await apiItem.addCart(event.idItem, count);
    result ? emit(SItemDetailAddSucces()) : emit(SItemDetailAddCartErorr());
  }

  // FutureOr<void> getAddressDefault(
  //     EItemDetailGetAddressDefault event, Emitter<ItemDetailState> emit) async {
  //   emit(SItemDetailVerifyLoading());
  //   dynamic result = await apiItem.getAddressHistory(event.idUser);
  //   result is AddressHistory ? emit(SItemDetailVerifySuccess(address: result)) : emit()
  // }
}
