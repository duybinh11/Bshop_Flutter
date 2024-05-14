import 'package:do_an2_1/BuyOrderDetail/bloc/buy_order_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/BillItemModel.dart';

// ignore: must_be_immutable
class BillMoneyCustom extends StatefulWidget {
  BillItemModel billModel;
  BillMoneyCustom({super.key, required this.billModel});

  @override
  State<BillMoneyCustom> createState() => _BillMoneyCustomState();
}

class _BillMoneyCustomState extends State<BillMoneyCustom> {
  TextStyle titles = const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuyOrderDetailBloc, BuyOrderDetailState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Expanded(
                child: DataTable(
                  border: const TableBorder(
                    top: BorderSide(),
                    right: BorderSide(),
                    left: BorderSide(),
                    bottom: BorderSide(),
                    verticalInside: BorderSide(),
                    horizontalInside: BorderSide(),
                  ),
                  columns: [
                    DataColumn(
                      label: Text('Tổng tiền', style: titles),
                    ),
                    DataColumn(
                      label: Text('Trạng thái', style: titles),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(
                        '${widget.billModel.money}VND',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      )),
                      DataCell(Text(widget.billModel.isPayment.toString(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700))),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
