// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rate_item_bloc.dart';

abstract class RateItemEvent {}

class ERateItemAdd extends RateItemEvent {
  int idOrder;
  double rateNum;
  String comment;
  int idItem;
  ERateItemAdd({
    required this.idOrder,
    required this.idItem,
    required this.rateNum,
    required this.comment,
  });
}
