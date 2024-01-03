import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:do_an2_1/Model/ItemModel.dart';

// import 'package:do_an_2/Model/ItemDetailModel.dart';
// import 'package:do_an_2/ItemDetalPage/ui/ItemDetailPage.dart';
// import 'package:do_an_2/Model/FlashSaleModel.dart';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../ItemDetail/ui/ItemDetailPage.dart';
import '../../Model/FlashSaleModel.dart';

// ignore: must_be_immutable
class BannerItem extends StatefulWidget {
  BannerItem({super.key, required this.listItemFlashSale});
  List<ItemModel> listItemFlashSale;
  @override
  State<BannerItem> createState() => _BannerState();
}

class _BannerState extends State<BannerItem> {
  int i = 0;

  CarouselController carouselCtl = CarouselController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          CarouselSlider(
              items: widget.listItemFlashSale
                  .map(
                    (e) => BannerCustom(
                      itemModel: e,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    i = index;
                  });
                },
                height: size.height * 0.26,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 1, // full page run
                autoPlay: true,
              )),
          Positioned(
            right: 0,
            left: 0,
            bottom: 5,
            child: DotsIndicator(
              position: i,
              onTap: (index) {
                carouselCtl.animateToPage(index, curve: Curves.easeInOut);
              },
              dotsCount: widget.listItemFlashSale.length,
              decorator: DotsDecorator(
                color: Colors.white,
                activeColor: Colors.amber,
                size: const Size.square(8.0), // size dot
                activeSize: const Size(18.0, 8.0), // size dot selected
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                spacing: const EdgeInsets.all(3.0), // space dot
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class BannerCustom extends StatelessWidget {
  BannerCustom({super.key, required this.itemModel});
  ItemModel itemModel;

  late FlashSaleModel fls = itemModel.flashSaleModel!;

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ItemDetailPage.routeName,
            arguments: {'id_item': itemModel.id});
      },
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: itemModel.img,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          Positioned(
              left: 10,
              top: 50,
              child: BlinkBlink(
                flashSaleModel: fls,
              )),
          Positioned(
              left: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(blurRadius: 8, spreadRadius: 1, color: Colors.black)
                ]),
                child: Text(
                  '${fls.timeEnd.hour}h${fls.timeEnd.minute} | ${fls.timeEnd.day}-${fls.timeEnd.month}-${fls.timeEnd.year}',
                  style: const TextStyle(color: Colors.amber, fontSize: 15),
                ),
              )),
          Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 10, spreadRadius: 1)],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  'Chỉ còn ${itemModel.price * (1 - fls.percent / 100) ~/ 1000}k',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber),
                ),
              ))
        ],
      ),
    );
  }
}

class BlinkBlink extends StatefulWidget {
  const BlinkBlink({super.key, required this.flashSaleModel});
  final FlashSaleModel flashSaleModel;
  @override
  State<BlinkBlink> createState() => _BlinkBlinkState();
}

class _BlinkBlinkState extends State<BlinkBlink> with TickerProviderStateMixin {
  // ignore: prefer_typing_uninitialized_variables
  late final animationCtl;
  // ignore: prefer_typing_uninitialized_variables
  late final animation;
  @override
  void initState() {
    animationCtl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..repeat(reverse: true);

    animation = CurvedAnimation(parent: animationCtl, curve: Curves.linear);
    super.initState();
  }

  @override
  void dispose() {
    animationCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            boxShadow: [
              BoxShadow(color: Colors.black, blurRadius: 8, spreadRadius: 1)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('assets/img/sale.png'),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '${widget.flashSaleModel.percent}%',
              style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 23,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
