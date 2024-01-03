import 'package:do_an2_1/OrderPage/bloc/order_page_bloc.dart';
import 'package:flutter/material.dart';

import 'OrderBody.dart';

class OrderPage extends StatefulWidget {
  static const routeName = '/OrderPage';
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late OrderPageBloc orderBloc;
  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Giỏ hàng',
              style: TextStyle(
                  fontFamily: 'popins1',
                  color: Colors.blue,
                  fontWeight: FontWeight.w700),
            ),
          ),
          body: const OrderBody(),
        ));
  }
}
