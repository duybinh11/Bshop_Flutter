import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/item_detail_bloc.dart';

class NamePay extends StatefulWidget {
  const NamePay({super.key});

  @override
  State<NamePay> createState() => _NamePayState();
}

class _NamePayState extends State<NamePay> {
  final List<String> _list = [
    'Thanh Toán sau khi nhận hàng',
    'Vnpay',
  ];
  String? pay = 'Thanh Toán sau khi nhận hàng';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Phương thức thanh toán',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(
          height: 5,
        ),
        DropdownMenu<String>(
          menuHeight: 200, 
          initialSelection: pay,
          dropdownMenuEntries:
              _list.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(
              value: value,
              label: value,
            );
          }).toList(),
          onSelected: (value) {
            setState(() {
              pay = value;
              // context
              //     .read<ItemDetailBloc>()
              //     .add(EItemDetailGetPay(namePay: pay));
            });
          },
        ),
      ],
    );
  }
}
