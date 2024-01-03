import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Login/bloc/login_bloc.dart';
import '../../Model/ItemCartModel.dart';
import '../bloc/cart_bloc.dart';

class SuffixIconCart extends StatefulWidget {
  const SuffixIconCart({super.key, required this.itemCartModel});
  final ItemCartModel itemCartModel;
  @override
  State<SuffixIconCart> createState() => _SuffixIconCartState();
}

class _SuffixIconCartState extends State<SuffixIconCart> {
  bool selected = false;
  void deleteCart(BuildContext context, int idCart) {
    int idUser = context.read<LoginBloc>().userModel!.id;
    context.read<CartBloc>().add(ECartDelete(idCart: idCart, idUser: idUser));
  }

  void addOrder(BuildContext context, ItemCartModel itemCartModel, bool isAdd) {
    setState(() {
      selected = isAdd;
    });
    context
        .read<CartBloc>()
        .add(ECartAddOrder(itemCartModel: itemCartModel, isAdd: isAdd));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              deleteCart(context, widget.itemCartModel.idCart);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
        Checkbox(
            value: selected,
            onChanged: (value) =>
                addOrder(context, widget.itemCartModel, value!)),
      ],
    );
  }
}
