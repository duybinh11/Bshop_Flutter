import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Model/ItemCartModel.dart';
import '../../OrderDetailPage/uiCart/OrderDetailPage.dart';
import '../../main.dart';
import '../bloc/cart_bloc.dart';

// ignore: must_be_immutable
class CartBottomCustom extends StatelessWidget {
  CartBottomCustom({
    super.key,
  });
  var formatter = NumberFormat('#,##0', 'vi_VN');
  void buyItem(BuildContext context) {
    List<ItemCartModel> listSelected =
        context.read<CartBloc>().listCartSelected;
    if (listSelected.isEmpty) {
      showDialog(
          context: context,
          builder: (context) =>
              showdialogCustom(context, 'Thông Báo', 'Vui lòng chọn mặt hàng'));
    } else {
      Navigator.pushNamed(context, OrderDetailPage.routeName,
          arguments: {'list_selected': listSelected});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.blue, boxShadow: [
          BoxShadow(blurRadius: 10, spreadRadius: 1, color: Colors.grey)
        ]),
        height: 60,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                'Tổng thanh toán : ',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              BlocBuilder<CartBloc, CartState>(
                buildWhen: (previous, current) {
                  if (current is SCartMoneyCart) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is SCartMoneyCart) {
                    return Text(
                      '${formatter.format(state.money)}VND',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    );
                  }
                  return const Text(
                    '0VND',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  );
                },
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: ElevatedButton(
                onPressed: () => buyItem(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text('Mua hàng'),
              ))
            ],
          ),
        ));
  }
}
