import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../BuyOrderDetail/ui/BuyOrderDetailPage.dart';
import '../../Model/BillItemModel.dart';
import '../../Model/ItemModel.dart';

// ignore: must_be_immutable
class ItemOrderCustom extends StatelessWidget {
  BillItemModel billItemModel;

  ItemOrderCustom({super.key, required this.billItemModel});

  @override
  Widget build(BuildContext context) {
    ItemModel itemModel = billItemModel.listOrder.first;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, BuyOrderDetailPage.routeName,
          arguments: {'billItemModel': billItemModel}),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
        height: 80,
        width: double.infinity,
        color: Colors.grey.withOpacity(0.2),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                children: [
                  SizedBox(
                    width: 100,
                    height: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: itemModel.img,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  billItemModel.listOrder.length > 1
                      ? Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          color: Colors.amber,
                          child: Text('+${billItemModel.listOrder.length}'),
                        )
                      : const SizedBox()
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      itemModel.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                  billItemModel.isVnpay
                      ? const Text(
                          'Vnpay',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      : const Text(
                          'Thanh toán sau khi nhận',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                  billItemModel.isPayment
                      ? const Text(
                          'Đã Thanh toán',
                          style: TextStyle(color: Colors.green),
                        )
                      : const Text('Chưa Thanh toán',
                          style: TextStyle(color: Colors.red))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
