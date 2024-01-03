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
  bool searching = false;
  int currentPage = 1;
  String nameSearch = '';
  HomeBloc() : super(HomeInitial()) {
    on<EHomeGetAllItem>(getAllItem);
    on<EHomePageGetItemByCategory>(getItemByCategory);
    on<EHomePageLoadMore>(loadMore);
    on<EHomePageOrderByPrice>(orderByPrice);
    on<EHomePageSearchItem>(searchItem);
    on<EHomePageDisableSearch>(disableSearch);
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
    List<ItemModel> listTemp = [];
    if (searching) {
      listTemp =
          await apiItem.searchItem(nameSearch, idCategory, isASC, currentPage);
    } else {
      listTemp =
          await apiItem.getItemByCategory(currentPage, idCategory, isASC);
    }

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
    List<ItemModel> listTemp = [];
    if (searching) {
      // if seaching emit state suiable
      listTemp =
          await apiItem.searchItem(nameSearch, idCategory, isASC, currentPage);
    } else {
      listTemp =
          await apiItem.getItemByCategory(currentPage, idCategory, isASC);
    }

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
    searching = true;
    nameSearch = event.name;
    currentPage = 1; //set page
    emit(SHomePageLoadingGrid());
    List<ItemModel> listItem =
        await apiItem.searchItem(nameSearch, idCategory, isASC, currentPage);
    if (listItem.isEmpty) {
      emit(SHomePageGridEmpty());
    } else {
      emit(SHomePageGridGetIem(listItem: listItem));
    }
  }

  FutureOr<void> disableSearch(
      EHomePageDisableSearch event, Emitter<HomeState> emit) {
    searching = false;
    nameSearch = '';
  }
}
