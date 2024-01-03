// ignore: must_be_immutable

import 'package:do_an2_1/Model/ItemCartModel.dart';
import 'package:do_an2_1/Model/ItemModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../CartPage/bloc/cart_bloc.dart';
import '../../Login/bloc/login_bloc.dart';

import '../../OrderDetailPage/uiCart/OrderDetailPage.dart';
import '../bloc/item_detail_bloc.dart';

// import 'VerifyBill.dart';

// ignore: must_be_immutable
class BtnItemDetail extends StatelessWidget {
  BtnItemDetail({super.key, required this.item});

  ItemModel item;
  void addCart(BuildContext context) {
    int idUser = context.read<LoginBloc>().userModel!.id;
    context
        .read<ItemDetailBloc>()
        .add(EItemDetailAddCart(idUser: idUser, idItem: item.id));

    initCartPage(context);
  }

  void initCartPage(BuildContext context) {
    int idUser = context.read<LoginBloc>().userModel!.id;
    context.read<CartBloc>().add(ECartGetallCart(idUser: idUser));
  }

  void clickBuy(BuildContext context) {
    List<ItemCartModel> listSelected = [];
    int amount = context.read<ItemDetailBloc>().count;
    ItemCartModel cartModel = ItemCartModel(
        idCart: 0,
        id: item.id,
        name: item.name,
        price: item.price,
        img: item.img,
        descrip: item.descrip,
        sold: item.sold,
        flashSaleModel: item.flashSaleModel,
        rateStar: item.rateStar,
        amount: amount,
        createdAt: DateTime.parse('2004-01-10 00:00:00.000000'));
    listSelected.add(cartModel);
    Navigator.pushNamed(context, OrderDetailPage.routeName,
        arguments: {'list_selected': listSelected});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            spreadRadius: 1,
            blurRadius: 10,
            color: Colors.grey.withOpacity(0.5))
      ]),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => addCart(context),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  backgroundColor: Colors.green),
              child: const Text(
                'Giỏ Hàng',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  backgroundColor: Colors.amber),
              onPressed: () => clickBuy(context),
              child: const Text(
                'Mua Hàng',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
