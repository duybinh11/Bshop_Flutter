import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an2_1/Model/ItemModel.dart';
import 'package:flutter/material.dart';

class AppBarItemDetail extends StatelessWidget {
  const AppBarItemDetail({
    super.key,
    required this.size,
    required this.item,
  });

  final Size size;
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        child: Stack(
          children: [
            Positioned(
              child: SizedBox(
                  height: size.height * 0.3,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: item.img,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  )),
            ),
            Positioned(
              left: 10,
              top: 50,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  child: Image.asset('assets/img/arrow.png'),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 50,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                padding: const EdgeInsets.all(10),
                height: 40,
                width: 40,
                child: Image.asset('assets/img/heart.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
