// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class SHomeLoading extends HomeState {}

final class SHomePageLoadingGrid extends HomeState {}

final class SHomePageGridEmpty extends HomeState {}

final class SHomeGetLoadingMore extends HomeState {}

final class SHomeGetLoadMoreEmpty extends HomeState {}

// ignore: must_be_immutable
class SHomePageGridGetIem extends HomeState {
  List<ItemModel> listItem;
  SHomePageGridGetIem({
    required this.listItem,
  });
}

// ignore: must_be_immutable
class SHomeGetAll extends HomeState {
  List<ItemModel> listItemFlashSale;
  List<ItemModel> listItemByCategory;
  SHomeGetAll(
      {required this.listItemFlashSale, required this.listItemByCategory});
}
