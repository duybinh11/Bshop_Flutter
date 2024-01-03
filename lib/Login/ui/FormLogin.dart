import 'package:do_an2_1/Login/bloc/login_bloc.dart';
import 'package:do_an2_1/RegisterPage/ui/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final keyForm = GlobalKey<FormState>();

  final emailCtl = TextEditingController();

  final passCtl = TextEditingController();

  bool isVisible = false;

  @override
  void dispose() {
    emailCtl.dispose();
    passCtl.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (!value!.contains('@')) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  void clickLogin(BuildContext context) {
    context
        .read<LoginBloc>()
        .add(ELoginLogin(email: emailCtl.text, password: passCtl.text));
  }

  void clickCreateAccount() {
    Navigator.pushNamed(context, RegisterPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 10)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Form(
          key: keyForm,
          child: Column(
            children: [
              TextFormField(
                controller: emailCtl,
                validator: validateEmail,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blue,
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return TextFormField(
                  controller: passCtl,
                  obscureText: isVisible,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        child: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                        onTap: () => setState(() => isVisible = !isVisible),
                      ),
                      labelText: 'Password',
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.blue,
                      )),
                );
              }),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (keyForm.currentState!.validate()) {
                    clickLogin(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)),
                child: const Text(
                  'login',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'popins1',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Quên mật khẩu',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: clickCreateAccount,
                    child: const Text(
                      'Tạo tài khoản',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
