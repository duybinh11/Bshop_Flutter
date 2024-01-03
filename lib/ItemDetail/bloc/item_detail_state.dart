// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'item_detail_bloc.dart';

abstract class ItemDetailState {}

final class ItemDetailInitial extends ItemDetailState {}

final class SItemDetailLoading extends ItemDetailState {}

final class SItemDetailGetErorr extends ItemDetailState {}

class SItemDetailGetData extends ItemDetailState {
  ItemModel item;
  ShopModel shopModel;
  SItemDetailGetData({required this.item, required this.shopModel});
}

class SItemDetailLoadingRate extends ItemDetailState {}

class SItemDetailRateEmpty extends ItemDetailState {}

class SItemDetailGetRate extends ItemDetailState {
  List<RateModel> listRate;
  SItemDetailGetRate({
    required this.listRate,
  });
}

class SItemDetailAddCartLoading extends ItemDetailState {}

class SItemDetailAddSucces extends ItemDetailState {}

class SItemDetailAddCartErorr extends ItemDetailState {}

class SItemDetailVerifyLoading extends ItemDetailState {}

class SItemDetailVerifySuccess extends ItemDetailState {
  AddressHistory address;
  SItemDetailVerifySuccess({
    required this.address,
  });
}

class SItemDetailBuyLoading extends ItemDetailState {}
