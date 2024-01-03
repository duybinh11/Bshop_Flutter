// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'item_detail_bloc.dart';

abstract class ItemDetailEvent {}

class EItemDetailGetData extends ItemDetailEvent {
  int id;
  EItemDetailGetData({
    required this.id,
  });
}

class EItemDetailUpdateCount extends ItemDetailEvent {
  int count;
  EItemDetailUpdateCount({
    required this.count,
  });
}

class EItemDetailRate extends ItemDetailEvent {
  int id;
  EItemDetailRate({
    required this.id,
  });
}

class EItemDetailAddCart extends ItemDetailEvent {
  int idItem;
  int idUser;
  EItemDetailAddCart({required this.idItem, required this.idUser});
}

class EItemDetailGetAddressDefault extends ItemDetailEvent {
  int idUser;
  EItemDetailGetAddressDefault({
    required this.idUser,
  });
}
