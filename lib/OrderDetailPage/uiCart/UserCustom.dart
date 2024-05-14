import 'package:do_an2_1/Model/AddressHistory.dart';
import 'package:do_an2_1/OrderDetailPage/bloc/order_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Login/bloc/login_bloc.dart';
import '../../Model/UserModel.dart';
import 'GetAddressHistory.dart';
import 'SelectProvince.dart';

// ignore: must_be_immutable
class UserCustom extends StatefulWidget {
  UserCustom({super.key, required this.address});
  AddressHistory? address;

  @override
  State<UserCustom> createState() => _UserCustomState();
}

class _UserCustomState extends State<UserCustom> {
  void selectAddress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (context) => const SelectProvince(),
    );
  }

  UserModel? userModel;
  @override
  void initState() {
    userModel = context.read<LoginBloc>().userModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration:
            BoxDecoration(border: Border.all(width: 3, color: Colors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Địa chỉ nhận hàng'),
                Icon(
                  Icons.place,
                  color: Colors.red,
                  size: 20,
                ),
              ],
            ),
            Text('${userModel?.username} | ${userModel?.phone}'),
            BlocBuilder<OrderDetailBloc, OrderDetailState>(
              buildWhen: (previous, current) {
                if (current is SOrderDetailSetAddress) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is SOrderDetailSetAddress) {
                  final address = state.address;
                  return Text(
                    address.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                }
                return Text(
                  widget.address.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const Text(
                    'Chọn Địa Chỉ nhận hàng mới',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  ),
                  onTap: () => selectAddress(context),
                ),
                GestureDetector(
                  child: const Icon(Icons.change_circle),
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => const GetAddressHistory(),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
