import 'package:do_an2_1/RateItemPage/ui/RateItemPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/ItemOrderModel.dart';
import '../../Model/StatusTransport.dart';
import '../bloc/buy_order_detail_bloc.dart';

class SateAddressSheet extends StatelessWidget {
  const SateAddressSheet({
    super.key,
    required this.itemOrder,
  });

  final ItemOrderModel itemOrder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyOrderDetailBloc, BuyOrderDetailState>(
      listener: (context, state) {
        if (state is SBuyOrderDetaiReceivedSuccess) {
          itemOrder.listStatusTransport.add(state.statusAddress);
        }
        if (state is SBuyOrderDetailRated) {
          itemOrder.isRate = true;
        }
      },
      builder: (context, state) {
        return Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: itemOrder.isShopConfirm
                ? Scaffold(
                    body: ListView.builder(
                      itemCount: itemOrder.listStatusTransport.length,
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.green,
                        margin: const EdgeInsets.all(5),
                        height: 40,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              itemOrder.listStatusTransport[index].place,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w800),
                            )),
                            Text(itemOrder.listStatusTransport[index].createdAt
                                .toString())
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar: BottomStateAddress(
                        itemOrder: itemOrder,
                        stateAddress: itemOrder.listStatusTransport.last))
                : const Center(child: Text('Chua xac nhan')));
      },
    );
  }
}

class BottomStateAddress extends StatelessWidget {
  const BottomStateAddress(
      {super.key, required this.stateAddress, required this.itemOrder});
  final StatusTransport stateAddress;
  final ItemOrderModel itemOrder;
  void clickRate(BuildContext context) {
    Navigator.pushNamed(context, RateItemPage.routeName,
        arguments: {'item_order': itemOrder});
  }

  void clickReceiveOrder(BuildContext context) {
    context
        .read<BuyOrderDetailBloc>()
        .add(EBuyOrderDetailUpdateReceived(idOrder: itemOrder.idOrder));
  }

  @override
  Widget build(BuildContext context) {
    if (stateAddress.place == 'Đang giao hàng') {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
            onPressed: () => clickReceiveOrder(context),
            child: const Text(
              'Đã nhận hàng',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            )),
      );
    }
    if (stateAddress.place == 'Đã nhận hàng') {
      if (itemOrder.isRate) {
        return Container(
          width: double.infinity,
          height: 40,
          alignment: Alignment.center,
          color: Colors.amber,
          child: const Text(
            'Đã đánh giá',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
            onPressed: () => clickRate(context),
            child: const Text(
              'Đánh giá',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            )),
      );
    }
    return const Text('null');
  }
}
