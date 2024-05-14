import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/order_detail_bloc.dart';
import 'DropdownCustom.dart';

class SelectProvince extends StatefulWidget {
  const SelectProvince({
    super.key,
  });

  @override
  State<SelectProvince> createState() => _SelectProvinceState();
}

class _SelectProvinceState extends State<SelectProvince> {
  final placeDetailCtl = TextEditingController(text: ' ');
  @override
  void initState() {
    context.read<OrderDetailBloc>().add(EOrderDetailGetProvien());
    super.initState();
  }

  @override
  void dispose() {
    placeDetailCtl.dispose();
    super.dispose();
  }

  void clickSaveAddress(BuildContext context) {
    context.read<OrderDetailBloc>().add(EOrderDetailAddAddress(
        placeDetail: placeDetailCtl.text, isDefault: isDefault));
  }

  bool isDefault = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      buildWhen: (previous, current) {
        if (current is SOrderDetaiGetAddrresLoading) {
          return true;
        }
        if (current is SOrderDetailProvince) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is SOrderDetaiGetAddrresLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SOrderDetailProvince) {
          return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownCustomProvince(
                        lists: state.listProvince,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<OrderDetailBloc, OrderDetailState>(
                        buildWhen: (previous, current) {
                          if (current is SOrderDetailDistrict) {
                            return true;
                          }
                          return false;
                        },
                        builder: (context, state) {
                          if (state is SOrderDetailDistrict) {
                            return DropdownCustomDistrict(
                              lists: state.listDistrict,
                            );
                          }
                          return const DropDefault();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<OrderDetailBloc, OrderDetailState>(
                        builder: (context, state) {
                          if (state is SOrderDetailWard) {
                            return DropdownCustomDWards(
                              lists: state.listWard,
                            );
                          }
                          return const DropDefault();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: placeDetailCtl,
                        decoration: const InputDecoration(
                            label: Text('Địa chỉ Cụ thể',
                                style: TextStyle(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 5),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero))),
                      ),
                      Row(
                        children: [
                          StatefulBuilder(
                            builder: (context, setState) => Checkbox(
                              value: isDefault,
                              onChanged: (value) {
                                setState(() => isDefault = value!);
                              },
                            ),
                          ),
                          const Text('Đặt làm mặc định')
                        ],
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => clickSaveAddress(context),
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      fixedSize: const Size(double.infinity, 50)),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              resizeToAvoidBottomInset: false);
        }
        return const Text('null');
      },
    );
  }
}
