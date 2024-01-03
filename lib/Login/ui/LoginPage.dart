import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ManagerPageHome/ui/ManagerPageHome.dart';
import '../../main.dart';
import '../bloc/login_bloc.dart';
import 'FormLogin.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/LoginPage';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SLoginFail) {
            showDialog(
              context: context,
              builder: (context) =>
                  showdialogCustom(context, 'Thông Báo', 'Đăng nhập thất bại'),
            );
          }
          if (state is SLoginSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, ManagerPageHome.routeName, (route) => false);
          }
        },
        builder: (context, state) {
          if (state is SLoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.asset('assets/img/login.jpg')),
              const Expanded(child: FormLogin())
            ],
          );
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
