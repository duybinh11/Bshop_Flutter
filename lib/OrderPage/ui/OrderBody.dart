import 'package:do_an2_1/OrderPage/bloc/order_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Login/bloc/login_bloc.dart';
import 'ItemOrderCustom.dart';

// ignore: must_be_immutable
class OrderBody extends StatefulWidget {
  const OrderBody({
    super.key,
  });

  @override
  State<OrderBody> createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    int idUser = context.read<LoginBloc>().userModel!.id;
    context.read<OrderPageBloc>().add(EOrderPageGetOrder(idUser: idUser));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<OrderPageBloc, OrderPageState>(
      builder: (context, state) {
        if (state is SOrderPagGetOrderLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SOrderPageOrderGetOrder) {
          return RefreshIndicator(
            onRefresh: () {
              return Future.sync(() {
                int idUser = context.read<LoginBloc>().userModel!.id;
                context
                    .read<OrderPageBloc>()
                    .add(EOrderPageGetOrder(idUser: idUser));
              });
            },
            child: ListView.builder(
              itemCount: state.listBill.length,
              itemBuilder: (context, index) =>
                  ItemOrderCustom(billItemModel: state.listBill[index]),
            ),
          );
        }
        if (state is SOrderPageGetOrderEmpty) {
          return const Text('empty');
        }
        if (state is SOrderPageErorr) {
          return const Text('erorr');
        }
        return const Text('null');
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
