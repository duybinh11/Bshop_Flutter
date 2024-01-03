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
  bool searching = false;
  @override
  void dispose() {
    searchCtl.dispose();
    super.dispose();
  }

  void clickIcon() {
    setState(() {
      searching = !searching;
    });
    if (searching) {
      context.read<HomeBloc>().add(EHomePageSearchItem(name: searchCtl.text));
    } else {
      searchCtl.clear();
      int idCategory = context.read<HomeBloc>().idCategory; //lay id cu
      context.read<HomeBloc>().add(EHomePageDisableSearch());
      context
          .read<HomeBloc>()
          .add(EHomePageGetItemByCategory(idCategory: idCategory));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                controller: searchCtl,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  color: searching ? Colors.red : Colors.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: IconButton(
                onPressed: clickIcon,
                icon: Icon(
                  searching ? Icons.cancel : Icons.search,
                  size: 27,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
