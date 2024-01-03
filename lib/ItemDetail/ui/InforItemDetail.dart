import 'package:do_an2_1/Model/ItemModel.dart';
import 'package:do_an2_1/Model/ShopModel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Model/FlashSaleModel.dart';
import '../../RateStar.dart';
import '../bloc/item_detail_bloc.dart';
import 'RateCustomItemDetail.dart';

// ignore: must_be_immutable
class InforItemDetail extends StatelessWidget {
  InforItemDetail(
      {super.key,
      required this.item,
      required this.size,
      required this.shopModel});

  final Size size;
  final ItemModel item;
  final ShopModel shopModel;
  var formatter = NumberFormat('#,##0', 'vi_VN');
  void clickShowRate(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (context) => RateCustom(idItem: item.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DividerItemDetail(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 21,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  RateStar(rateAvg: item.rateStar, fixSize: 19)
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              DescripCustom(item: item),
              const SizedBox(
                height: 5,
              ),
              CostItemDetail(
                  flashSaleModel: item.flashSaleModel,
                  formatter: formatter,
                  itemModel: item),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              ShopCustom(shopModel: shopModel, formatter: formatter),
              const Divider(),
              item.flashSaleModel == null
                  ? const SizedBox()
                  : FlashSaleCustomItemDetail(
                      flashSaleModel: item.flashSaleModel!,
                    ),
              GestureDetector(
                  onTap: () => clickShowRate(context),
                  child: const Text(
                    'Xem Đánh Giá',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  )),
              const SizedBox(
                height: 5,
              ),
              const CountItemDetailCustom(),
            ],
          ),
        ),
      ),
    );
  }
}

class CountItemDetailCustom extends StatefulWidget {
  const CountItemDetailCustom({
    super.key,
  });

  @override
  State<CountItemDetailCustom> createState() => _CountItemDetailCustomState();
}

class _CountItemDetailCustomState extends State<CountItemDetailCustom> {
  int count = 1;
  void increaseCount() {
    setState(() {
      count++;
      context.read<ItemDetailBloc>().add(EItemDetailUpdateCount(count: count));
    });
  }

  void minusCount() {
    if (count > 1) {
      setState(() {
        count--;
        context
            .read<ItemDetailBloc>()
            .add(EItemDetailUpdateCount(count: count));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Text(
        'Số Lượng Mua : ',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        onTap: increaseCount,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(4))),
          height: 20,
          width: 20,
          alignment: Alignment.center,
          child: const Text(
            '+',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Container(
        decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        height: 20,
        width: 20,
        alignment: Alignment.center,
        child: Text('$count',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700)),
      ),
      const SizedBox(
        width: 4,
      ),
      GestureDetector(
        onTap: minusCount,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(4))),
          height: 20,
          width: 20,
          alignment: Alignment.center,
          child: const Text('-',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        ),
      )
    ]);
  }
}

class ShopCustom extends StatelessWidget {
  const ShopCustom({
    super.key,
    required this.shopModel,
    required this.formatter,
  });

  final ShopModel shopModel;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      leading: ClipOval(
        child: CircleAvatar(
          child: Image.network(shopModel.img),
        ),
      ),
      title: Text(shopModel.username),
      subtitle: Text('${formatter.format(shopModel.follower)} Người theo dõi'),
    );
  }
}

class CostItemDetail extends StatelessWidget {
  const CostItemDetail({
    super.key,
    required this.flashSaleModel,
    required this.formatter,
    required this.itemModel,
  });

  final FlashSaleModel? flashSaleModel;
  final NumberFormat formatter;
  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Giá : ',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            flashSaleModel == null
                ? Text(
                    '${formatter.format(itemModel.price)}k',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${itemModel.price}đ',
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 2.0,
                            decorationColor: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${formatter.format(itemModel.price * (1 - flashSaleModel!.percent / 100))}k',
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
          ],
        ),
        Text('Đã bán : ${itemModel.sold}')
      ],
    );
  }
}

class DividerItemDetail extends StatelessWidget {
  const DividerItemDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 7,
        width: 100,
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
    );
  }
}

// ignore: must_be_immutable
class FlashSaleCustomItemDetail extends StatelessWidget {
  FlashSaleCustomItemDetail({super.key, required this.flashSaleModel});
  FlashSaleModel flashSaleModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Flash Sale',
              style: TextStyle(
                  fontFamily: 'popins1',
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            'Giảm ${flashSaleModel.percent}%',
            style: const TextStyle(
                fontWeight: FontWeight.w800, color: Colors.red, fontSize: 15),
          ),
          Text(
            'Bắt đầu từ : ${flashSaleModel.timeStart.hour}h${flashSaleModel.timeStart.minute} '
            '${flashSaleModel.timeStart.day}/${flashSaleModel.timeStart.month}/${flashSaleModel.timeStart.year}',
          ),
          Text(
            'Đến ngày : ${flashSaleModel.timeEnd.hour}h${flashSaleModel.timeEnd.minute} '
            '${flashSaleModel.timeEnd.day}/${flashSaleModel.timeEnd.month}/${flashSaleModel.timeEnd.year}',
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class DescripCustom extends StatefulWidget {
  const DescripCustom({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  State<DescripCustom> createState() => _DescripCustomState();
}

class _DescripCustomState extends State<DescripCustom> {
  bool isExpand = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.item.descrip,
          maxLines: isExpand ? null : 3,
          overflow: isExpand ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: Text(
            isExpand ? 'Ẩn bớt' : 'xem thêm',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
