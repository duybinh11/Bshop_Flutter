import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an2_1/ItemDetail/ui/ItemDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Model/ItemCartModel.dart';
import '../../RateStar.dart';
import 'AmountCart.dart';
import 'SuffixIconCart.dart';

// ignore: must_be_immutable
class CartCustom extends StatelessWidget {
  const CartCustom({
    super.key,
    required this.itemCart,
  });

  final ItemCartModel itemCart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ItemDetailPage.routeName,
          arguments: {'id_item': itemCart.id}),
      child: SizedBox(
        width: double.infinity,
        height: 110,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ImgCartCustom(itemCart: itemCart),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          itemCart.name,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    TotalMoney(itemCart: itemCart),
                    RateStar(rateAvg: itemCart.rateStar, fixSize: 17),
                    AmountCart(itemCart: itemCart),
                  ],
                ),
              ),
              SuffixIconCart(itemCartModel: itemCart)
            ],
          ),
        ),
      ),
    );
  }
}

class ImgCartCustom extends StatelessWidget {
  const ImgCartCustom({
    super.key,
    required this.itemCart,
  });

  final ItemCartModel itemCart;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              imageUrl: itemCart.img,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        itemCart.flashSaleModel != null
            ? Positioned(
                top: 3,
                right: 3,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    '-${itemCart.flashSaleModel!.percent}%',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ))
            : const SizedBox(),
      ],
    );
  }
}

// ignore: must_be_immutable
class TotalMoney extends StatelessWidget {
  TotalMoney({super.key, required this.itemCart});
  final ItemCartModel itemCart;
  var formatter = NumberFormat('#,##0', 'vi_VN');
  bool selected = false;
  bool isDelete = false;

  int totalMoney(ItemCartModel itemCart) {
    return itemCart.flashSaleModel == null
        ? itemCart.price
        : (itemCart.price * (1 - itemCart.flashSaleModel!.percent / 100))
            .toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Giá : ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        itemCart.flashSaleModel != null
            ? Text(
                '${formatter.format(itemCart.price)}VND',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration:
                      TextDecoration.lineThrough, // Thêm đường gạch ở giữa
                  decorationColor: Colors.black, // Màu sắc của đường gạch
                  decorationThickness: 2.0, // Độ dày của đường gạch
                ),
              )
            : const SizedBox(),
        const SizedBox(
          width: 5,
        ),
        Text(
          '${formatter.format(totalMoney(itemCart))}VND',
          style:
              const TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
        ),
      ],
    );
  }
}
