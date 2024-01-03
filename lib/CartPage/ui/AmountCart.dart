import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/ItemCartModel.dart';
import '../bloc/cart_bloc.dart';

class AmountCart extends StatefulWidget {
  const AmountCart({super.key, required this.itemCart});
  final ItemCartModel itemCart;

  @override
  State<AmountCart> createState() => _AmountCartState();
}

class _AmountCartState extends State<AmountCart> {
  void changeSl(BuildContext context, ItemCartModel cart, bool isTang) {
    if (isTang) {
      setState(() {
        cart.amount++;
      });
      context
          .read<CartBloc>()
          .add(ECartChangeSl(itemCartModel: cart, isTang: isTang));
    } else {
      if (cart.amount > 1) {
        setState(() {
          cart.amount--;
        });
        cart.amount >= 1
            ? context
                .read<CartBloc>()
                .add(ECartChangeSl(itemCartModel: cart, isTang: false))
            : null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Số lượng : ',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 17),
        ),
        const SizedBox(
          width: 30,
        ),
        GestureDetector(
          onTap: () => changeSl(context, widget.itemCart, false),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            width: 20,
            alignment: Alignment.center,
            child: const Text(
              '-',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '${widget.itemCart.amount}',
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () => changeSl(context, widget.itemCart, true),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            width: 20,
            alignment: Alignment.center,
            child: const Text(
              '+',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
            ),
          ),
        ),
      ],
    );
  }
}
