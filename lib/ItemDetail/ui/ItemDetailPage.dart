import 'package:do_an2_1/ItemDetail/bloc/item_detail_bloc.dart';
import 'package:do_an2_1/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AppBarItemDetail.dart';
import 'BtnItemDetail.dart';
import 'InforItemDetail.dart';

// ignore: must_be_immutable
class ItemDetailPage extends StatefulWidget {
  static const String routeName = '/ItemDetailPage';
  const ItemDetailPage({super.key});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late int id;
  late ItemDetailBloc itemDetailBloc;
  bool isLoad = false;

  @override
  void didChangeDependencies() {
    if (!isLoad) {
      Map<String, dynamic> map =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      id = map['id_item'] as int;
      itemDetailBloc = context.read<ItemDetailBloc>();
      itemDetailBloc.add(EItemDetailGetData(id: id));
      isLoad = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    itemDetailBloc.clearBloc();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocConsumer<ItemDetailBloc, ItemDetailState>(
        listener: (context, state) {
          if (state is SItemDetailAddCartLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => showdialogLoading(context),
            );
          }
          if (state is SItemDetailAddSucces) {
            Navigator.pop(context); // off dialog loding
            showDialog(
              context: context,
              builder: (context) => showdialogCustom(
                  context, 'Thông báo', 'Đã thêm vào giỏ hàng'),
            );
          }
          if (state is SItemDetailAddCartErorr) {
            Navigator.pop(context); // off dialog loding
            showDialog(
              context: context,
              builder: (context) => showdialogCustom(
                  context, 'Thông báo', 'Lỗi thêm vào giỏ hàng'),
            );
          }
        },
        buildWhen: (previous, current) {
          if (current is SItemDetailGetErorr) {
            return true;
          }
          if (current is SItemDetailGetData) {
            return true;
          }
          if (current is SItemDetailLoading) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is SItemDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SItemDetailGetData) {
            final item = state.item;
            final shopModel = state.shopModel;
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  AppBarItemDetail(size: size, item: item),
                  InforItemDetail(item: item, size: size, shopModel: shopModel),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 50),
                  ),
                ],
              ),
              bottomNavigationBar: BtnItemDetail(item: item),
            );
          }

          if (state is SItemDetailGetErorr) {
            return const Text('loi');
          }
          return const SizedBox(
            child: Text('null'),
          );
        },
      ),
    );
  }
}
