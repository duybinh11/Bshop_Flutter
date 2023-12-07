import 'package:do_an2_1/Model/ItemModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import 'ItemCustom.dart';

class GridHomeCustom extends StatelessWidget {
  const GridHomeCustom({super.key, required this.listItem});
  final List<ItemModel> listItem;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        if (current is SHomePageLoadingGrid) {
          return true;
        }
        if (current is SHomePageGridGetIem) {
          return true;
        }
        if (current is SHomePageGridEmpty) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is SHomePageLoadingGrid) {
          return const SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is SHomePageGridEmpty) {
          return const SliverToBoxAdapter(
            child: Center(child: Text('empty')),
          );
        }
        if (state is SHomePageGridGetIem) {
          final listItem = state.listItem;
          return SliverPadding(
            padding: const EdgeInsets.only(right: 5, left: 5),
            sliver: SliverGrid.builder(
                key: UniqueKey(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: 0.85),
                itemCount: listItem.length,
                itemBuilder: (context, index) => ItemCustom(
                      itemModel: listItem[index],
                    )),
          );
        }

        //default
        return SliverPadding(
          padding: const EdgeInsets.only(right: 5, left: 5),
          sliver: SliverGrid.builder(
              key: UniqueKey(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  childAspectRatio: 0.85),
              itemCount: listItem.length,
              itemBuilder: (context, index) => ItemCustom(
                    itemModel: listItem[index],
                  )),
        );
      },
    );
  }
}
