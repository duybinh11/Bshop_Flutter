import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_an2_1/Api/ApiItem.dart';
import 'package:do_an2_1/Api/ApiVnpay.dart';
import 'package:do_an2_1/Model/BillItemModel.dart';
import 'package:do_an2_1/Model/StatusTransport.dart';
import 'package:meta/meta.dart';

part 'buy_order_detail_event.dart';
part 'buy_order_detail_state.dart';

class BuyOrderDetailBloc
    extends Bloc<BuyOrderDetailEvent, BuyOrderDetailState> {
  ApiVnpay apiVnpay = ApiVnpay();
  ApiItem apiItem = ApiItem();
  BuyOrderDetailBloc() : super(BuyOrderDetailInitial()) {
    on<EBuyOrderDetailUpdateReceived>(updateReceived);
    on<EBuyOrderDetailRated>(rated);
    on<EBuyOrderDetailGetBillRefresh>(getBillRefresh);
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

  FutureOr<void> rated(
      EBuyOrderDetailRated event, Emitter<BuyOrderDetailState> emit) {
    emit(SBuyOrderDetailRated());
  }

  FutureOr<void> getBillRefresh(EBuyOrderDetailGetBillRefresh event,
      Emitter<BuyOrderDetailState> emit) async {
    emit(SBuyOrderDetailBillLoading());
    BillItemModel? bill = await apiItem.getBillRefresh(idBill: event.idBill);
    Future.delayed(Duration(seconds: 1));
    emit(SBuyOrderDetailBillRefreshSuccess(billItemModel: bill!));
  }
}
