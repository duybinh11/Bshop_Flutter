import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an2_1/Model/FlashSaleModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Model/ItemModel.dart';
import '../../RateStar.dart';

// ignore: must_be_immutable
class ItemCustom extends StatelessWidget {
  ItemCustom({
    super.key,
    required this.itemModel,
  });

  final ItemModel itemModel;
  late FlashSaleModel? flashSaleModel = itemModel.flashSaleModel;
  var formatter = NumberFormat('#,##0', 'vi_VN');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, ItemDetailPage.routeName,
        //     arguments: {'id_item': itemModel.id});
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: itemModel.img,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  flashSaleModel == null
                      ? const SizedBox()
                      : Positioned(
                          top: 3,
                          right: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.amber,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            padding: const EdgeInsets.all(4),
                            child: Text('-${flashSaleModel!.percent}%',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                          )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: Column(
                children: [
                  Text(
                    itemModel.name,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  RateStar(
                    rateAvg: itemModel.rateStar,
                    fixSize: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${formatter.format(itemModel.price)}VND',
                        style: const TextStyle(
                          fontFamily: 'popins1',
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Đã bán ${formatter.format(itemModel.sold)}',
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
