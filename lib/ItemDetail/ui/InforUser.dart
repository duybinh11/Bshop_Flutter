import 'package:flutter/material.dart';

import '../../Model/UserModel.dart';

// ignore: must_be_immutable
class InforUser extends StatelessWidget {
  InforUser({super.key, required this.userModel});
  UserModel userModel;
  TextStyle titles = const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Thông Tin Người Nhận',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: double.infinity,
          child: DataTable(
            dataRowHeight: 60, // Điều chỉnh độ cao của các dòng
            columnSpacing: 30, // Điều chỉnh khoảng cách giữa các cột
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
                label: Text('Tên', style: titles),
              ),
              DataColumn(
                label: Text('SDT', style: titles),
              )
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text(userModel.username,
                    style: const TextStyle(fontSize: 17))),
                DataCell(
                  Text(
                    userModel.phone,
                    style: const TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
