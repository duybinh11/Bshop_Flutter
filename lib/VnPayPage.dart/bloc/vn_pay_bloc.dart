import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_an2_1/Api/ApiItem.dart';
import 'package:do_an2_1/Api/ApiVnpay.dart';
import 'package:do_an2_1/OrderDetailPage/bloc/order_detail_bloc.dart';

part 'vn_pay_event.dart';
part 'vn_pay_state.dart';

class VnPayBloc extends Bloc<VnPayEvent, VnPayState> {
  int? idBill;
  ApiVnpay apiVnpay = ApiVnpay();
  ApiItem apiItem = ApiItem();
  VnPayBloc() : super(VnPayInitial()) {
    on<EVnpayGetUrl>(getUrl);
    on<EVnPayAddVnpayBuyItem>(buyItem);
    on<EVnPayAddVnpay>(addVnpay);
    on<EVnpayUpdateBill>(updateBill);
  }
  void clear() {
    idBill = null;
  }

  FutureOr<void> getUrl(EVnpayGetUrl event, Emitter<VnPayState> emit) async {
    emit(SVnPayLoading());
    Map<String, dynamic> mapData = await apiVnpay.getUrl(event.money);
    mapData['code'] == '00'
        ? emit(SVnpayGetUrlSuccesss(url: mapData['data']))
        : emit(SVnPayGetUrlErorr());
  }

  FutureOr<void> buyItem(
      EVnPayAddVnpayBuyItem event, Emitter<VnPayState> emit) async {
    OrderDetailBloc orderDetailBloc = event.orderDetailBloc;
    Map<String, dynamic> mapData = await apiItem.addBill(
        listCart: orderDetailBloc.listSelected!,
        idAdress: orderDetailBloc.addressDefault1!.id,
        money: orderDetailBloc.totalMoney,
        isVnpay: 1);
    idBill = mapData['id_bill'];
  }

  FutureOr<void> addVnpay(
      EVnPayAddVnpay event, Emitter<VnPayState> emit) async {
    emit(SVnPayLoading());
    bool check = await apiVnpay.addVnpay(
        idBill: idBill!,
        idBanking: event.id,
        bankCode: event.bankCode,
        money: event.money,
        isPayment: event.isPayMent);
    if (check && event.isPayMent == 1) {
      emit(SVnPayPaymentSuccess());
    } else if (check) {
      emit(SVnPayPaymentNotPay());
    } else {
      emit(SVnPayPaymentErorr());
    }
  }

  FutureOr<void> updateBill(EVnpayUpdateBill event, Emitter<VnPayState> emit) {
    apiVnpay.updateBill(idBill!);
  }
}
