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
  void initState() {
    if (widget.billModel.isVnpay) {
      context
          .read<BuyOrderDetailBloc>()
          .add(EBuyOrderDetailGetVnpay(idBill: widget.billModel.id));
    }
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuyOrderDetailBloc, BuyOrderDetailState>(
      builder: (context, state) {
        if (state is SBuyOrderDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SBuyOrderDetaiVNpay) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(
                  child: DataTable(
                    // ignore: deprecated_member_use
                    dataRowHeight: 60, // Điều chỉnh độ cao của các dòng
                    columnSpacing: 20, // Điều chỉnh khoảng cách giữa các cột
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
                        label: Text('State', style: titles),
                      ),
                      widget.billModel.isVnpay
                          ? DataColumn(
                              label: Text('PTTT', style: titles),
                            )
                          : const DataColumn(label: SizedBox()),
                      widget.billModel.isVnpay
                          ? DataColumn(
                              label: Text('Time', style: titles),
                            )
                          : const DataColumn(label: SizedBox()),
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
                        widget.billModel.isVnpay
                            ? const DataCell(Text('Vnpay',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)))
                            : const DataCell(SizedBox()),
                        widget.billModel.isVnpay
                            ? DataCell(Text('${state.vnpayModel.createdAt}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)))
                            : const DataCell(SizedBox()),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
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
