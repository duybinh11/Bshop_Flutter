import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../Model/ItemOrderModel.dart';
import 'SateAddressSheet.dart';

class ItemOrderStateCustom extends StatelessWidget {
  const ItemOrderStateCustom({
    super.key,
    required this.itemOrder,
  });

  final ItemOrderModel itemOrder;
  void getStateAddress(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        builder: (context) => SateAddressSheet(itemOrder: itemOrder));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => getStateAddress(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
        child: SizedBox(
          height: 70,
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: itemOrder.item.img,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  fit: BoxFit.cover,
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
                      itemOrder.item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      itemOrder.isShopConfirm
                          ? Expanded(
                              child: Text(
                              itemOrder.listStatusTransport.last.place,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ))
                          : const Expanded(
                              child: Text(
                                'Chờ xác nhận',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                      Text('X${itemOrder.amount}')
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
