import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_an2_1/Api/ApiItem.dart';
import 'package:do_an2_1/Api/ApiVnpay.dart';
import 'package:do_an2_1/Model/StatusTransport.dart';
import 'package:do_an2_1/Model/VnpayModel.dart';
import 'package:meta/meta.dart';

part 'buy_order_detail_event.dart';
part 'buy_order_detail_state.dart';

class BuyOrderDetailBloc
    extends Bloc<BuyOrderDetailEvent, BuyOrderDetailState> {
  ApiVnpay apiVnpay = ApiVnpay();
  ApiItem apiItem = ApiItem();
  BuyOrderDetailBloc() : super(BuyOrderDetailInitial()) {
    on<EBuyOrderDetailGetVnpay>(getVnpay);
    on<EBuyOrderDetailUpdateReceived>(updateReceived);
    on<EBuyOrderDetailReset>(reset);
  }

  FutureOr<void> getVnpay(
      EBuyOrderDetailGetVnpay event, Emitter<BuyOrderDetailState> emit) async {
    emit(SBuyOrderDetailLoading());
    VnpayModel? vnpayModel = await apiVnpay.getVnpay(event.idBill);
    emit(SBuyOrderDetaiVNpay(vnpayModel: vnpayModel!));
  }

  FutureOr<void> updateReceived(EBuyOrderDetailUpdateReceived event,
      Emitter<BuyOrderDetailState> emit) async {
    StatusTransport? temp =
        await apiItem.updateReceived(idOrder: event.idOrder);
    temp != null
        ? emit(SBuyOrderDetaiReceivedSuccess(
            statusAddress: temp, idOrder: event.idOrder))
        : null;
  }

  FutureOr<void> reset(
      EBuyOrderDetailReset event, Emitter<BuyOrderDetailState> emit) {
    emit(SBuyOrderDetailReset());
  }
}
