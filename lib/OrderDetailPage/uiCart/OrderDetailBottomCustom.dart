import 'package:do_an2_1/OrderDetailPage/bloc/order_detail_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Login/bloc/login_bloc.dart';
import '../../Model/ItemCartModel.dart';
import '../../VnPayPage.dart/ui/VnPayPage.dart';

// ignore: must_be_immutable
class OrderDetailBottomCustom extends StatelessWidget {
  OrderDetailBottomCustom({super.key, required this.listSelected});
  List<ItemCartModel> listSelected;
  var formatter = NumberFormat('#,##0', 'vi_VN');
  int totalCost(BuildContext context) {
    int sum = 0;
    for (var element in listSelected) {
      sum += cost(element);
    }
    context.read<OrderDetailBloc>().add(EOrderDetailSetMoney(totalMoney: sum));
    return sum;
  }

  int cost(ItemCartModel itemCartModel) {
    return itemCartModel.flashSaleModel == null
        ? itemCartModel.price * itemCartModel.amount
        : itemCartModel.amount *
            (itemCartModel.price *
                    (1 - itemCartModel.flashSaleModel!.percent / 100))
                .toInt();
  }

  void order(BuildContext context) {
    String namePay = context.read<OrderDetailBloc>().namePay;
    if (namePay == 'Thanh Toán sau khi nhận hàng') {
      int idUser = context.read<LoginBloc>().userModel!.id;
      context.read<OrderDetailBloc>().add(EOrderDetailBuyItem(idUser: idUser));
    } else {
      Navigator.pushNamed(context, VnPayPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.blue,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Tổng : ${formatter.format(totalCost(context))}VND',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => order(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text('Đặt hàng'),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
