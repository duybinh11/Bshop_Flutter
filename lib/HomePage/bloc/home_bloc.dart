import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_an2_1/Api/ApiItem.dart';
import 'package:do_an2_1/Model/ItemModel.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ApiItem apiItem = ApiItem();
  List<ItemModel> listItem = [];
  int isASC = 1;
  int idCategory = 0;
  int currentPage = 1;
  HomeBloc() : super(HomeInitial()) {
    on<EHomeGetAllItem>(getAllItem);
    on<EHomePageGetItemByCategory>(getItemByCategory);
    on<EHomePageLoadMore>(loadMore);
    on<EHomePageOrderByPrice>(orderByPrice);
    on<EHomePageSearchItem>(searchItem);
  }

  FutureOr<void> getAllItem(
      EHomeGetAllItem event, Emitter<HomeState> emit) async {
    emit(SHomeLoading());
    listItem.clear();
    currentPage = 1; //
    List<dynamic> results = await Future.wait(
        [apiItem.getItemFlashSale(), apiItem.getItemByCategory(1, 0, isASC)]);
    List<ItemModel> listItemFlashSale = results[0];
    List<ItemModel> listItemByCategory = results[1];

    listItem.addAll(listItemByCategory); // save listItemByCategory to loadmore

    emit(SHomeGetAll(
        listItemFlashSale: listItemFlashSale,
        listItemByCategory: listItemByCategory));
  }

  FutureOr<void> getItemByCategory(
      EHomePageGetItemByCategory event, Emitter<HomeState> emit) async {
    emit(SHomePageLoadingGrid());
    idCategory = event.idCategory;
    currentPage = 1;
    listItem.clear(); // delete when click category khác
    List<ItemModel> listTemp =
        await apiItem.getItemByCategory(currentPage, idCategory, isASC);
    if (listTemp.isEmpty) {
      emit(SHomePageGridEmpty());
    } else {
      listItem.addAll(listTemp);
      emit(SHomePageGridGetIem(listItem: listItem));
    }
  }

  FutureOr<void> loadMore(
      EHomePageLoadMore event, Emitter<HomeState> emit) async {
    emit(SHomeGetLoadingMore());
    currentPage++;
    List<ItemModel> listTemp =
        await apiItem.getItemByCategory(currentPage, idCategory, isASC);
    await Future.delayed(const Duration(seconds: 1));
    if (listTemp.isEmpty) {
      emit(SHomeGetLoadMoreEmpty());
    } else {
      listItem.addAll(listTemp);
      emit(SHomePageGridGetIem(listItem: listItem));
    }
  }

  FutureOr<void> orderByPrice(
      EHomePageOrderByPrice event, Emitter<HomeState> emit) async {
    isASC = event.isASC;
    await getItemByCategory(
        EHomePageGetItemByCategory(idCategory: idCategory), emit);
  }

  FutureOr<void> searchItem(
      EHomePageSearchItem event, Emitter<HomeState> emit) async {
    emit(SHomePageLoadingGrid());
    List<ItemModel> listItem = await apiItem.searchItem(event.name);
    if (listItem.isEmpty) {
      emit(SHomePageGridEmpty());
    } else {
      emit(SHomePageGridGetIem(listItem: listItem));
    }
  }
}
