import 'package:flutter/material.dart';

class BackgroudRegisterPage extends StatelessWidget {
  const BackgroudRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 250,
      child: Stack(
        children: [
          Positioned(
            top: -300,
            left: -100,
            child: Container(
              height: 500,
              width: 500,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
            ),
          ),
          Positioned(
            right: 30,
            left: 30,
            bottom: 0,
            child: SizedBox(
                width: 300,
                height: 300,
                child: Image.asset('assets/img/signup.png')),
          ),
          Positioned(
            top: 40,
            left: 0,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  size: 30,
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
