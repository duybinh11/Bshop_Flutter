import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_an2_1/Api/ApiItem.dart';
import 'package:do_an2_1/Api/ApiProvince.dart';
import 'package:do_an2_1/Model/AddressHistory.dart';
import 'package:do_an2_1/Model/ProvinceVn.dart';

import '../../Model/ItemCartModel.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  String namePay = 'Thanh Toán sau khi nhận hàng';
  int totalMoney = 0;
  ApiItem apiItem = ApiItem();
  String? province;
  String? district;
  String? ward;
  bool? isDefault;
  List<ItemCartModel>? listSelected;
  AddressHistory? addressDefault1;
  ApiProvince apiProvince = ApiProvince();
  OrderDetailBloc() : super(OrderDetailInitial()) {
    on<EOrderDetailSetNamePay>(setNamePay);
    on<EOrderDetailSetMoney>(setTotalMoney);
    on<EOrderDetailGetAddressDefault>(addressDefault);
    on<EOrderDetailGetProvien>(getProvince);
    on<EOrderDetailSetProvien>(setProvince);
    on<EOrderDetailSetDistrict>(setDistrict);
    on<EOrderDetailSetWard>(setWard);
    on<EOrderDetailAddAddress>(addAddress);
    on<EOrderDetailGetAddress>(getAddressHistory);
    on<EOrderDetailSetAddressDefault>(setAddressDefault);
    on<EOrderDetailSetAddressDefaultDB>(setAddressDefaultDB);
    on<EOrderDetailSetListCart>(setListCart);
    on<EOrderDetailBuyItem>(buyItem);
  }
  void clearBloc() {
    namePay = 'Thanh Toán sau khi nhận hàng';
    totalMoney = 0;
    province = null;
    district = null;
    ward = null;
    isDefault = null;
    addressDefault1 = null;
    listSelected = null;
  }

  FutureOr<void> setListCart(
      EOrderDetailSetListCart event, Emitter<OrderDetailState> emit) {
    listSelected = event.listSelected;
  }

  FutureOr<void> setNamePay(
      EOrderDetailSetNamePay event, Emitter<OrderDetailState> emit) {
    namePay = event.namePay;
  }

  FutureOr<void> setTotalMoney(
      EOrderDetailSetMoney event, Emitter<OrderDetailState> emit) {
    totalMoney = event.totalMoney;
  }

  FutureOr<void> addressDefault(EOrderDetailGetAddressDefault event,
      Emitter<OrderDetailState> emit) async {
    emit(SOrderDetaiLoading());
    addressDefault1 = await apiItem.getAddressDefault(event.idUser);
    emit(SOrderDetai(addressHistory: addressDefault1));
  }

  FutureOr<void> getProvince(
      EOrderDetailGetProvien event, Emitter<OrderDetailState> emit) async {
    emit(SOrderDetaiGetAddrresLoading());
    List<ProvinceVn> listProvince = await apiProvince.getProvince();
    emit(SOrderDetailProvince(listProvince: listProvince));
  }

  FutureOr<void> setProvince(
      EOrderDetailSetProvien event, Emitter<OrderDetailState> emit) {
    province = event.province.name;
    emit(SOrderDetailDistrict(listDistrict: event.province.districts));
  }

  FutureOr<void> setDistrict(
      EOrderDetailSetDistrict event, Emitter<OrderDetailState> emit) {
    district = event.districts.name;

    emit(SOrderDetailWard(listWard: event.districts.wards));
  }

  FutureOr<void> setWard(
      EOrderDetailSetWard event, Emitter<OrderDetailState> emit) {
    ward = event.ward.name;
  }

  FutureOr<void> addAddress(
      EOrderDetailAddAddress event, Emitter<OrderDetailState> emit) async {
    emit(SOrderDetaiGetAddrresLoading());
    if (province == null || district == null || ward == null) {
      emit(SOrderDetailFillInData());
    } else {
      bool result = await apiItem.addAdress(
          idUser: event.idUser,
          province: province!,
          district: district!,
          ward: ward!,
          isDefault: event.isDefault,
          placeDetail: event.placeDetail);

      result ? emit(SOrderDetailAddSucces()) : null;
    }
  }

  FutureOr<void> getAddressHistory(
      EOrderDetailGetAddress event, Emitter<OrderDetailState> emit) async {
    emit(SOrderDetaiGetAddrresLoading());
    List<AddressHistory> listAddress =
        await apiItem.getAddressHistory(event.idUser);
    listAddress.isEmpty
        ? emit(SOrderDetailGetAddressEmpty())
        : emit(SOrderDetailGetAddressSuccess(listAddress: listAddress));
  }

  FutureOr<void> setAddressDefault(
      EOrderDetailSetAddressDefault event, Emitter<OrderDetailState> emit) {
    addressDefault1 = event.addressDefault;
    emit(SOrderDetailSetAddress(address: addressDefault1!));
  }

  FutureOr<void> setAddressDefaultDB(
      EOrderDetailSetAddressDefaultDB event, Emitter<OrderDetailState> emit) {
    if (addressDefault1 != null) {
      apiItem.setAddressHistory(addressDefault1!.id);
    }
  }

  FutureOr<void> buyItem(
      EOrderDetailBuyItem event, Emitter<OrderDetailState> emit) async {
    if (addressDefault1 == null) {
      emit(SOrderDetailAddressNull());
    } else {
      int isVnPay = namePay == 'Thanh Toán sau khi nhận hàng' ? 0 : 1;
      emit(SOrderDetaiBuyLoading());
      Map<String, dynamic> mapData = await apiItem.addBill(
          idAdress: addressDefault1!.id,
          idUser: event.idUser,
          isVnpay: isVnPay,
          listCart: listSelected!,
          money: totalMoney);
      mapData['status']
          ? emit(SCartOrderBuySuccess())
          : emit(SCartOrderBuyErorr());
    }
  }
}
