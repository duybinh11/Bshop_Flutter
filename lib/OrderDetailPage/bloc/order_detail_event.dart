// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_detail_bloc.dart';

abstract class OrderDetailEvent {}

class EOrderDetailSetNamePay extends OrderDetailEvent {
  String namePay;
  EOrderDetailSetNamePay({
    required this.namePay,
  });
}

class EOrderDetailSetMoney extends OrderDetailEvent {
  int totalMoney;
  EOrderDetailSetMoney({
    required this.totalMoney,
  });
}

class EOrderDetailGetAddressDefault extends OrderDetailEvent {
  int idUser;
  EOrderDetailGetAddressDefault({
    required this.idUser,
  });
}

class EOrderDetailGetProvien extends OrderDetailEvent {}

class EOrderDetailSetProvien extends OrderDetailEvent {
  ProvinceVn province;
  EOrderDetailSetProvien({
    required this.province,
  });
}

class EOrderDetailSetDistrict extends OrderDetailEvent {
  Districts districts;
  EOrderDetailSetDistrict({required this.districts});
}

class EOrderDetailSetWard extends OrderDetailEvent {
  Wards ward;
  EOrderDetailSetWard({required this.ward});
}

class EOrderDetailAddAddress extends OrderDetailEvent {
  int idUser;
  bool isDefault;
  String placeDetail;
  EOrderDetailAddAddress(
      {required this.idUser,
      required this.isDefault,
      required this.placeDetail});
}

class EOrderDetailGetAddress extends OrderDetailEvent {
  int idUser;
  EOrderDetailGetAddress({required this.idUser});
}

class EOrderDetailSetAddressDefault extends OrderDetailEvent {
  AddressHistory addressDefault;
  EOrderDetailSetAddressDefault({required this.addressDefault});
}

class EOrderDetailSetAddressDefaultDB extends OrderDetailEvent {}

class EOrderDetailSetListCart extends OrderDetailEvent {
  List<ItemCartModel> listSelected;
  EOrderDetailSetListCart({
    required this.listSelected,
  });
}

class EOrderDetailBuyItem extends OrderDetailEvent {
  int idUser;
  EOrderDetailBuyItem({
    required this.idUser,
  });
}
