import 'package:do_an2_1/HomePage/bloc/home_bloc.dart';
import 'package:do_an2_1/HomePage/ui/FilterItem.dart';
import 'package:do_an2_1/HomePage/ui/GridHomeCustom.dart';
import 'package:do_an2_1/HomePage/ui/HomeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BannerItem.dart';
import 'LoadingMore.dart';
import 'SearchItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scCtl = ScrollController();
  late HomeBloc homeBloc;

  @override
  void initState() {
    scCtl.addListener(() {
      if (scCtl.position.maxScrollExtent == scCtl.offset) {
        homeBloc.add(EHomePageLoadMore());
      }
    });
    initHomePage(context);
    super.initState();
  }

  void initHomePage(BuildContext context) {
    homeBloc = context.read<HomeBloc>();
    homeBloc.add(EHomeGetAllItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) {
          if (current is SHomeLoading) {
            return true;
          }
          if (current is SHomeGetAll) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is SHomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SHomeGetAll) {
            return RefreshIndicator(
              onRefresh: () =>
                  Future.sync(() => homeBloc.add(EHomeGetAllItem())),
              child: CustomScrollView(
                controller: scCtl,
                slivers: [
                  const HomeAppBar(),
                  BannerItem(
                    listItemFlashSale: state.listItemFlashSale,
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 5,
                    ),
                  ),
                  const HomeSearch(),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 5,
                    ),
                  ),
                  const FiterItem(),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  GridHomeCustom(listItem: state.listItemByCategory),
                  const SliverToBoxAdapter(
                    child: LoadingMore(),
                  ),
                ],
              ),
            );
          }
          return const Text('null');
        },
      ),
    );
  }
}
