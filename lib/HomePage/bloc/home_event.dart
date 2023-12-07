// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent {}

class EHomeGetAllItem extends HomeEvent {}

class EHomePageLoadMore extends HomeEvent {}

class EHomePageGetItemByCategory extends HomeEvent {
  int idCategory;
  EHomePageGetItemByCategory({
    required this.idCategory,
  });
}

class EHomePageOrderByPrice extends HomeEvent {
  int isASC;
  EHomePageOrderByPrice({
    required this.isASC,
  });
}

class EHomePageSearchItem extends HomeEvent {
  String name;
  EHomePageSearchItem({
    required this.name,
  });
}
