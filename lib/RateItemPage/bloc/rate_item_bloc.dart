import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_an2_1/Api/ApiItem.dart';
import 'package:do_an2_1/Model/ItemOrderModel.dart';
import 'package:meta/meta.dart';

part 'rate_item_event.dart';
part 'rate_item_state.dart';

class RateItemBloc extends Bloc<RateItemEvent, RateItemState> {
  ApiItem apiItem = ApiItem();
  RateItemBloc() : super(RateItemInitial()) {
    on<ERateItemAdd>(addRate);
  }

  FutureOr<void> addRate(
      ERateItemAdd event, Emitter<RateItemState> emit) async {
    emit(SRateItemLoading());
    bool check = await apiItem.rateAddItem(
        idItem: event.idItem,
        comment: event.comment,
        idOrder: event.idOrder,
        idUser: event.idUser,
        rate: event.rateNum);
    check ? emit(SRateItemSuccess()) : emit(SRateItemErorr());
  }
}
