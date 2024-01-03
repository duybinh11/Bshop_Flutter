import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_an2_1/Api/ApiItem.dart';
import 'package:do_an2_1/Model/BillItemModel.dart';

part 'order_page_event.dart';
part 'order_page_state.dart';

class OrderPageBloc extends Bloc<OrderPageEvent, OrderPageState> {
  ApiItem apiItem = ApiItem();
  OrderPageBloc() : super(OrderPageInitial()) {
    on<EOrderPageGetOrder>(getOrderWaiting);
  }

  FutureOr<void> getOrderWaiting(
      EOrderPageGetOrder event, Emitter<OrderPageState> emit) async {
    emit(SOrderPagGetOrderLoading());
    Map<String, dynamic> mapData =
        await apiItem.getOrderWaiting(idUser: event.idUser);
    if (mapData['status'] as bool) {
      List<dynamic> listData = mapData['id_bill'];

      emit(SOrderPageOrderGetOrder(
          listBill: listData.map((e) => BillItemModel.fromMap(e)).toList()));
    } else {
      emit(SOrderPageErorr());
    }
  }
}
