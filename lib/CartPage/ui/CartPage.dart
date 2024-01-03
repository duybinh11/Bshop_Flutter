import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Login/bloc/login_bloc.dart';
import '../bloc/cart_bloc.dart';
import 'CartBottomCustom.dart';
import 'CartCustom.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    initCartPage();
    super.initState();
  }

  initCartPage() {
    int idUser = context.read<LoginBloc>().userModel!.id;
    context.read<CartBloc>().add(ECartGetallCart(idUser: idUser));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(
              fontFamily: 'popins1',
              color: Colors.blue,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) {
          if (current is SCartLoading) {
            return true;
          }
          if (current is SCartEmpty) {
            return true;
          }
          if (current is SCartAllCart) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is SCartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SCartEmpty) {
            return const Text('empty');
          }
          if (state is SCartAllCart) {
            return Scaffold(
              body: RefreshIndicator(
                onRefresh: () {
                  initCartPage();
                  return Future.delayed(const Duration(seconds: 1));
                },
                child: ListView.builder(
                  itemCount: state.listCart.length,
                  itemBuilder: (context, index) =>
                      CartCustom(itemCart: state.listCart[index]),
                ),
              ),
              bottomNavigationBar: CartBottomCustom(),
            );
          }
          return const Text('null');
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
