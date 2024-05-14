import 'package:do_an2_1/Login/bloc/login_bloc.dart';
import 'package:do_an2_1/OrderDetailPage/bloc/order_detail_bloc.dart';
import 'package:do_an2_1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../CartPage/bloc/cart_bloc.dart';
import '../../Model/ItemCartModel.dart';
import 'NamePayOrder.dart';
import 'OrderDetailBottomCustom.dart';

import 'OrderCustom.dart';
import 'UserCustom.dart';

// ignore: must_be_immutable
class OrderDetailPage extends StatefulWidget {
  static const routeName = '/COrderDetailPage';
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late List<ItemCartModel> listSelected;
  late OrderDetailBloc orderDetailBloc;
  bool isLoad = false;
  @override
  void dispose() {
    orderDetailBloc.clearBloc();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isLoad) {
      Map<String, dynamic> map =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      listSelected = map['list_selected'] as List<ItemCartModel>;
      orderDetailBloc = context.read<OrderDetailBloc>();
      orderDetailBloc.add(EOrderDetailGetAddressDefault());
      orderDetailBloc.add(EOrderDetailSetListCart(listSelected: listSelected));
      isLoad = true;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đơn Hàng',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocConsumer<OrderDetailBloc, OrderDetailState>(
        listener: (context, state) {
          if (state is SCartOrderBuySuccess) {
            Navigator.pop(context);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  showdialogCustom(context, 'Thong bao', 'Mua hang thanh cong'),
            );
          }
          if (state is SCartOrderBuyErorr) {
            Navigator.pop(context);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  showdialogCustom(context, 'Thong bao', 'Mua hang that bai'),
            );
          }
          if (state is SOrderDetailAddressNull) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => showdialogCustom(
                  context, 'Thong bao', 'Chọn địa chỉ nhận hàng'),
            );
          }
          if (state is SOrderDetaiBuyLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => showdialogLoading(context),
            );
          }
          if (state is SOrderDetailFillInData) {
            Navigator.pop(context);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => showdialogCustom(
                  context, 'Thong bao', 'nhap day du thong tin'),
            );
          }
          if (state is SOrderDetailAddSucces) {
            Navigator.pop(context);
          }
        },
        buildWhen: (previous, current) {
          if (current is SOrderDetaiLoading) {
            return true;
          }
          if (current is SOrderDetai) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is SOrderDetaiLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SOrderDetai) {
            return Column(
              children: [
                Column(
                    children: List.generate(
                        listSelected.length,
                        (index) =>
                            OrderCustom(cartModel: listSelected[index]))),
                const SizedBox(
                  height: 10,
                ),
                UserCustom(address: state.addressHistory),
                const NamePayOrder()
              ],
            );
          }
          return const Text('null');
        },
      ),
      bottomNavigationBar: OrderDetailBottomCustom(listSelected: listSelected),
    );
  }
}
