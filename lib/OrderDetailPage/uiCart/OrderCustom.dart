// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Model/ItemCartModel.dart';

// ignore: must_be_immutable
class OrderCustom extends StatelessWidget {
  OrderCustom({super.key, required this.cartModel});
  var formatter = NumberFormat('#,##0', 'vi_VN');
  ItemCartModel cartModel;
  int cost(ItemCartModel cartModel) {
    return cartModel.flashSaleModel == null
        ? cartModel.price
        : (cartModel.price * (1 - cartModel.flashSaleModel!.percent / 100))
            .toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
                height: 70,
                width: 70,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: cartModel.img,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        cartModel.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ),
                  ),
                  Text(
                    'Đã bán : ${cartModel.sold}',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Giá : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          cartModel.flashSaleModel != null
                              ? Text(
                                  '${formatter.format(cartModel.price)}VND',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration
                                        .lineThrough, // Thêm đường gạch ở giữa
                                    decorationColor:
                                        Colors.black, // Màu sắc của đường gạch
                                    decorationThickness:
                                        2.0, // Độ dày của đường gạch
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${formatter.format(cost(cartModel))}VND',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, color: Colors.red),
                          ),
                        ],
                      ),
                      Text(
                        'x${cartModel.amount}',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
