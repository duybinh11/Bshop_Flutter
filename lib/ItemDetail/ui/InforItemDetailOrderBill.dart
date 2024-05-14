import 'package:do_an2_1/Model/ItemModel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/item_detail_bloc.dart';

// ignore: must_be_immutable
class InforItemDetailOrderBill extends StatelessWidget {
  InforItemDetailOrderBill({super.key, required this.item});
  ItemModel item;

  TextStyle titles = const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hóa Đơn',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: double.infinity,
          child: DataTable(
            columnSpacing: 25,
            border: const TableBorder(
                top: BorderSide(),
                right: BorderSide(),
                left: BorderSide(),
                bottom: BorderSide(),
                verticalInside: BorderSide(),
                horizontalInside: BorderSide()),
            columns: [
              DataColumn(
                  label: Text(
                'Giá(vnd)',
                style: titles,
              )),
              DataColumn(
                  label: Text(
                'Giảm giá',
                style: titles,
              )),
              DataColumn(
                label: Text(
                  'SL',
                  style: titles,
                ),
              ),
              DataColumn(
                  label: Text(
                'Tiền(vnd)',
                style: titles,
              )),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(
                  Text(
                    '100k',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                    'percent',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                    'sl',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                    '100',
                    style: TextStyle(fontSize: 17),
                  ),
                )
              ])
            ],
          ),
        ),
      ],
    );
  }
}
