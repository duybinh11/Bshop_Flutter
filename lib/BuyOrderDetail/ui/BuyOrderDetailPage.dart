import 'package:do_an2_1/BuyOrderDetail/bloc/buy_order_detail_bloc.dart';
import 'package:do_an2_1/BuyOrderDetail/ui/UserCustom.dart';
import 'package:do_an2_1/Model/BillItemModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BillMoneyCustom.dart';
import 'ItemOrderStateCustom.dart';

class BuyOrderDetailPage extends StatefulWidget {
  static const String routeName = '/BuyOrderDetailPage';
  const BuyOrderDetailPage({super.key});

  @override
  State<BuyOrderDetailPage> createState() => _BuyOrderDetailPageState();
}

class _BuyOrderDetailPageState extends State<BuyOrderDetailPage> {
  late BillItemModel billItemModel;
  @override
  void didChangeDependencies() {
    Map<String, dynamic> map =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    billItemModel = map['billItemModel'] as BillItemModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Chi Tiet don hang')),
        body: BlocConsumer<BuyOrderDetailBloc, BuyOrderDetailState>(
          listener: (context, state) {
            // if (state is SBuyOrderDetaiReceivedSuccess) {
            //   print(billItemModel.listOrder.length);
            //   for (var element in billItemModel.listOrder) {
            //     if (element.id == state.idOrder) {
            //       element.listStatusTransport.add(state.statusAddress);
            //     }
            //   }
            //   print(billItemModel.listOrder.length);
            // }
          },
          builder: (context, state) {
            
            return Column(
              children: [
                Column(
                  children: List.generate(
                      billItemModel.listOrder.length,
                      (index) => ItemOrderStateCustom(
                            itemOrder: billItemModel.listOrder[index],
                          )),
                ),
                const SizedBox(
                  height: 10,
                ),
                UserCustom(address: billItemModel.address),
                const SizedBox(
                  height: 5,
                ),
                BillMoneyCustom(billModel: billItemModel),
              ],
            );
          },
        ));
  }
}
