import 'dart:core';

import 'package:do_an2_1/Model/ProvinceVn.dart';
import 'package:do_an2_1/OrderDetailPage/bloc/order_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class DropdownCustomProvince extends StatefulWidget {
  DropdownCustomProvince({super.key, required this.lists});
  List<ProvinceVn> lists;

  @override
  State<DropdownCustomProvince> createState() => _DropdownCustomProvinceState();
}

class _DropdownCustomProvinceState extends State<DropdownCustomProvince> {
  late ProvinceVn province;
  @override
  void initState() {
    province = widget.lists.first;
    context
        .read<OrderDetailBloc>()
        .add(EOrderDetailSetProvien(province: province));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
      decoration: BoxDecoration(border: Border.all(width: 1)),
      width: double.infinity,
      child: DropdownButton<ProvinceVn>(
        isExpanded: true,
        value: province,
        items: widget.lists
            .map((e) => DropdownMenuItem<ProvinceVn>(
                  value: e,
                  child: Text(e.name),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            province = value!;
          });
          context
              .read<OrderDetailBloc>()
              .add(EOrderDetailSetProvien(province: value!));
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class DropdownCustomDistrict extends StatefulWidget {
  DropdownCustomDistrict({super.key, required this.lists});
  List<Districts> lists;

  @override
  State<DropdownCustomDistrict> createState() => _DropdownCustomDistrictState();
}

class _DropdownCustomDistrictState extends State<DropdownCustomDistrict> {
  late Districts district;
  @override
  void initState() {
    district = widget.lists.first;
    context
        .read<OrderDetailBloc>()
        .add(EOrderDetailSetDistrict(districts: district));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
      decoration: BoxDecoration(border: Border.all(width: 1)),
      width: double.infinity,
      child: DropdownButton<Districts>(
        isExpanded: true,
        value: widget.lists.first,
        items: widget.lists
            .map((e) => DropdownMenuItem<Districts>(
                  value: e,
                  child: Text(e.name),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            district = value!;
            context
                .read<OrderDetailBloc>()
                .add(EOrderDetailSetDistrict(districts: district));
          });
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class DropdownCustomDWards extends StatefulWidget {
  DropdownCustomDWards({super.key, required this.lists});
  List<Wards> lists;

  @override
  State<DropdownCustomDWards> createState() => _DropdownCustomWardsState();
}

class _DropdownCustomWardsState extends State<DropdownCustomDWards> {
  late Wards wards;
  @override
  void initState() {
    wards = widget.lists.first;
    context.read<OrderDetailBloc>().add(EOrderDetailSetWard(ward: wards));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
      decoration: BoxDecoration(border: Border.all(width: 1)),
      width: double.infinity,
      child: DropdownButton<Wards>(
        isExpanded: true,
        value: widget.lists.first,
        items: widget.lists
            .map((e) => DropdownMenuItem<Wards>(
                  value: e,
                  child: Text(e.name),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            wards = value!;
            context
                .read<OrderDetailBloc>()
                .add(EOrderDetailSetWard(ward: wards));
          });
        },
      ),
    );
  }
}

class DropDefault extends StatelessWidget {
  const DropDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
      decoration: BoxDecoration(border: Border.all(width: 1)),
      width: double.infinity,
      child: DropdownButton<String>(
        isExpanded: true,
        items: const [DropdownMenuItem<String>(child: Text('Lua chon'))],
        onChanged: (value) {},
      ),
    );
  }
}
