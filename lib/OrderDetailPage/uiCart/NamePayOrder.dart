import 'package:do_an2_1/OrderDetailPage/bloc/order_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NamePayOrder extends StatefulWidget {
  const NamePayOrder({super.key});

  @override
  State<NamePayOrder> createState() => _NamePayOrderState();
}

class _NamePayOrderState extends State<NamePayOrder> {
  @override
  void dispose() {
    super.dispose();
  }

  final List<String> _list = [
    'Thanh Toán sau khi nhận hàng',
    'Vnpay',
  ];
  String pay = 'Thanh Toán sau khi nhận hàng';

  void selectNamePay(String? value) {
    setState(() {
      pay = value!;
      context
          .read<OrderDetailBloc>()
          .add(EOrderDetailSetNamePay(namePay: value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Phương thức thanh toán',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  border: Border.all(width: 1)),
              child: DropdownButton(
                isExpanded: true,
                focusColor: Colors.blue,
                iconEnabledColor: Colors.blue,
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w700),
                value: pay,
                items: _list
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                          ),
                        ))
                    .toList(),
                onChanged: selectNamePay,
              ),
            )
          ],
        ),
      ),
    );
  }
}
