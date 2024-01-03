import 'package:do_an2_1/Model/AddressHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Login/bloc/login_bloc.dart';
import '../bloc/order_detail_bloc.dart';

class GetAddressHistory extends StatefulWidget {
  const GetAddressHistory({
    super.key,
  });

  @override
  State<GetAddressHistory> createState() => _GetAddressHistoryState();
}

class _GetAddressHistoryState extends State<GetAddressHistory> {
  int i = 0;
  @override
  void initState() {
    int idUser = context.read<LoginBloc>().userModel!.id;
    context.read<OrderDetailBloc>().add(EOrderDetailGetAddress(idUser: idUser));
    super.initState();
  }

  void clickSaveDefault(BuildContext context) {
    isDefault
        ? context.read<OrderDetailBloc>().add(EOrderDetailSetAddressDefaultDB())
        : null;
    Navigator.pop(context);
  }

  bool isDefault = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        buildWhen: (previous, current) {
          if (current is SOrderDetaiGetAddrresLoading) {
            return true;
          }
          if (current is SOrderDetailGetAddressEmpty) {
            return true;
          }
          if (current is SOrderDetailGetAddressSuccess) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is SOrderDetaiGetAddrresLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SOrderDetailGetAddressEmpty) {
            return const Center(child: Text('empty'));
          }
          if (state is SOrderDetailGetAddressSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropAddress(
                  listAddress: state.listAddress,
                ),
                Row(
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) => Checkbox(
                        value: isDefault,
                        onChanged: (value) {
                          setState(() {
                            isDefault = value!;
                            context
                                .read<OrderDetailBloc>()
                                .add(EOrderDetailSetAddressDefaultDB());
                          });
                        },
                      ),
                    ),
                    const Text(
                      'Đặt làm mặt định',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    )
                  ],
                )
              ],
            );
          }
          return const Text('null');
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => clickSaveDefault(context),
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              fixedSize: const Size(double.infinity, 50)),
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DropAddress extends StatefulWidget {
  DropAddress({super.key, required this.listAddress});
  List<AddressHistory> listAddress;

  @override
  State<DropAddress> createState() => _DropAddressState();
}

class _DropAddressState extends State<DropAddress> {
  late AddressHistory address1;
  @override
  void initState() {
    address1 = widget.listAddress.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
        decoration: BoxDecoration(border: Border.all(width: 1)),
        width: double.infinity,
        child: DropdownButton<AddressHistory>(
          isExpanded: true,
          value: address1,
          items: widget.listAddress.map((address) {
            return DropdownMenuItem<AddressHistory>(
              value: address,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${address.province} | ${address.district}'),
                    Text(
                      '${address.town} | ${address.placeDetail}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              address1 = value!;
              context
                  .read<OrderDetailBloc>()
                  .add(EOrderDetailSetAddressDefault(addressDefault: value));
            });
          },
        ));
  }
}
