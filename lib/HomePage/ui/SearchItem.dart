import 'package:do_an2_1/HomePage/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({
    super.key,
  });

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  TextEditingController searchCtl = TextEditingController();
  @override
  void dispose() {
    searchCtl.dispose();
    super.dispose();
  }

  void submit(String value) {
    context.read<HomeBloc>().add(EHomePageSearchItem(name: value));
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            hintText: 'Search',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintStyle: TextStyle(color: Colors.black),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
              weight: 200,
            ),
          ),
          controller: searchCtl,
          onSubmitted: submit,
        ),
      ),
    );
  }
}
