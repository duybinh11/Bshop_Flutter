import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: const Text(
        'BFood',
        style: TextStyle(
            fontFamily: 'popins1',
            color: Colors.blue,
            fontWeight: FontWeight.w700),
      ),
      actions: [
        SizedBox(
          width: 28,
          height: 28,
          child: Badge(
              label: const Text('3'),
              child: Image.asset('assets/img/messenger.png')),
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
