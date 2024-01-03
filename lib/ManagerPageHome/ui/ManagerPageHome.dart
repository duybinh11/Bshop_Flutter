import 'package:do_an2_1/CartPage/ui/CartPage.dart';
import 'package:do_an2_1/OrderPage/ui/OrderPage.dart';
import 'package:do_an2_1/ProfilePage/ui/ProfilePage.dart';
import 'package:flutter/material.dart';

import '../../HomePage/ui/HomePage.dart';

class ManagerPageHome extends StatefulWidget {
  static const String routeName = '/ManagerPageHome';
  const ManagerPageHome({super.key});

  @override
  State<ManagerPageHome> createState() => _ManagerPageHomeState();
}

class _ManagerPageHomeState extends State<ManagerPageHome> {
  @override
  void initState() {
    super.initState();
  }

  int i = 0;
  PageController pageCtl = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageCtl,
        onPageChanged: (value) {
          setState(() {
            i = value;
          });
        },
        children: const [HomePage(), CartPage(), OrderPage(), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        iconSize: 25,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              backgroundColor: Colors.blue,
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_travel),
              backgroundColor: Colors.blue,
              label: 'Giỏ hàng'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              backgroundColor: Colors.blue,
              label: 'Đơn hàng'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              backgroundColor: Colors.blue,
              label: 'Tài khoản')
        ],
        currentIndex: i,
        onTap: (value) {
          setState(() {
            i = value;
            pageCtl.animateToPage(value,
                duration: const Duration(microseconds: 200),
                curve: Curves.ease);
          });
        },
      ),
    );
  }
}
