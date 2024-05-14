import 'package:do_an2_1/Model/AddressHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Login/bloc/login_bloc.dart';
import '../../Model/UserModel.dart';

// ignore: must_be_immutable
class UserCustom extends StatefulWidget {
  UserCustom({super.key, required this.address});
  AddressHistory address;

  @override
  State<UserCustom> createState() => _UserCustomState();
}

class _UserCustomState extends State<UserCustom> {
  @override
  Widget build(BuildContext context) {
    UserModel? userModel = context.read<LoginBloc>().userModel;
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
            Text(
              widget.address.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
