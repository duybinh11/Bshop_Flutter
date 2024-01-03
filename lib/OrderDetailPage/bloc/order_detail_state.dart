// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_detail_bloc.dart';

abstract class OrderDetailState {}

final class OrderDetailInitial extends OrderDetailState {}

final class SOrderDetaiBuyLoading extends OrderDetailState {}

final class SOrderDetaiLoading extends OrderDetailState {}

final class SOrderDetaiGetAddrresLoading extends OrderDetailState {}

class SOrderDetai extends OrderDetailState {
  AddressHistory? addressHistory;
  SOrderDetai({
    this.addressHistory,
  });
}

class SOrderDetailProvince extends OrderDetailState {
  List<ProvinceVn> listProvince;
  SOrderDetailProvince({
    required this.listProvince,
  });
}

class SOrderDetailDistrict extends OrderDetailState {
  List<Districts> listDistrict;
  SOrderDetailDistrict({
    required this.listDistrict,
  });
}

class SOrderDetailWard extends OrderDetailState {
  List<Wards> listWard;
  SOrderDetailWard({
    required this.listWard,
  });
}

class SOrderDetailAddSucces extends OrderDetailState {}

class SOrderDetailGetAddressLoading extends OrderDetailState {}

class SOrderDetailGetAddressSuccess extends OrderDetailState {
  List<AddressHistory> listAddress;
  SOrderDetailGetAddressSuccess({
    required this.listAddress,
  });
}

class SOrderDetailGetAddressEmpty extends OrderDetailState {}

class SOrderDetailSetAddress extends OrderDetailState {
  AddressHistory address;
  SOrderDetailSetAddress({
    required this.address,
  });
}

class SOrderDetailFillInData extends OrderDetailState {}

class SOrderDetailAddressNull extends OrderDetailState {}

final class SCartOrderBuySuccess extends OrderDetailState {}

final class SCartOrderBuyErorr extends OrderDetailState {}
