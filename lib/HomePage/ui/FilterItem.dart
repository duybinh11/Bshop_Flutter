import 'package:do_an2_1/HomePage/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/CategoryModel.dart';

class FiterItem extends StatefulWidget {
  const FiterItem({
    super.key,
  });

  @override
  State<FiterItem> createState() => _FiterItemState();
}

class _FiterItemState extends State<FiterItem> {
  int i = 0;

  List<CategoryModel> listCategory = [
    CategoryModel(id: 0, name: 'All'),
    CategoryModel(id: 6, name: 'New'),
    CategoryModel(id: 1, name: 'Fashion'),
    CategoryModel(id: 2, name: 'Food'),
    CategoryModel(id: 3, name: 'Sport'),
    CategoryModel(id: 4, name: 'SkinCare'),
    CategoryModel(id: 5, name: 'Book'),
  ];
  List<String> priceSorts = [
    'Thấp đến cao',
    'Cao đến thấp',
  ];
  String? priceOrder;
  CategoryModel? newValue;
  @override
  void initState() {
    newValue = listCategory.first;
    priceOrder = priceSorts.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        height: 40,
        width: 700,
        child: Row(
          children: [
            const Text(
              'Giá',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(7))),
                child: DropdownButton(
                  isExpanded: true,
                  focusColor: Colors.blue,
                  iconEnabledColor: Colors.blue,
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w700),
                  value: priceOrder,
                  items: priceSorts
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() {
                    value == 'Thấp đến cao'
                        ? context
                            .read<HomeBloc>()
                            .add(EHomePageOrderByPrice(isASC: 1))
                        : context
                            .read<HomeBloc>()
                            .add(EHomePageOrderByPrice(isASC: 0));
                    priceOrder = value;
                  }),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'Mặt hàng',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(7))),
                child: DropdownButton(
                  isExpanded: true,
                  focusColor: Colors.blue,
                  iconEnabledColor: Colors.blue,
                  value: newValue,
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w700),
                  items: listCategory
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.name,
                            ),
                          ))
                      .toList(),
                  onChanged: (value1) => setState(() {
                    context.read<HomeBloc>().add(
                        EHomePageGetItemByCategory(idCategory: value1!.id));
                    newValue = value1;
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
