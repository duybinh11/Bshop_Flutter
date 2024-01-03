import 'package:do_an2_1/RegisterPage/bloc/register_bloc.dart';
import 'package:do_an2_1/RegisterPage/ui/BackgroudRegister.dart';
import 'package:do_an2_1/RegisterPage/ui/FormRegisterPage.dart';
import 'package:do_an2_1/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  static const String routeName = '/RegisterPage';
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is SRegisterErorr) {
              showDialog(
                context: context,
                builder: (context) => showdialogCustom(
                    context, 'Message', 'register ${state.erorr}'),
              );
            }
            if (state is SRegisterSuccess) {
              showDialog(
                context: context,
                builder: (context) =>
                    showdialogCustom(context, 'Message', 'register success'),
              );
            }
          },
          builder: (context, state) {
            if (state is SRegisterLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Column(
              children: [
                BackgroudRegisterPage(),
                Expanded(child: FormRegisterPage())
              ],
            );
          },
        ),
        resizeToAvoidBottomInset: false);
  }
}
