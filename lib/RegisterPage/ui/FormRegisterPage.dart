import 'package:do_an2_1/ProfilePage/bloc/profile_bloc.dart';
import 'package:do_an2_1/RegisterPage/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Login/ui/LoginPage.dart';

class FormRegisterPage extends StatefulWidget {
  const FormRegisterPage({
    super.key,
  });

  @override
  State<FormRegisterPage> createState() => _FormRegisterPageState();
}

class _FormRegisterPageState extends State<FormRegisterPage> {
  final keyForm = GlobalKey<FormState>();
  final emailCtl = TextEditingController();
  final usernamelCtl = TextEditingController();
  final phoneCtl = TextEditingController();
  final pass1Ctl = TextEditingController();
  final pass2Ctl = TextEditingController();
  final addressCtl = TextEditingController();
  @override
  void dispose() {
    emailCtl.dispose();
    usernamelCtl.dispose();
    addressCtl.dispose();
    phoneCtl.dispose();
    pass1Ctl.dispose();
    pass2Ctl.dispose();
    super.dispose();
  }

  String? emailValidate(String? value) {
    if (!value!.contains('@')) {
      return 'Email invalid';
    }
    return null;
  }

  String? inputlValidate(String? value) {
    if (value!.length < 5) {
      return 'Length >= 5';
    }
    return null;
  }

  String? confirmPass(String? value) {
    if (value != pass1Ctl.text) {
      return 'Confirm password  invalid';
    }
    return null;
  }

  void clickSignUp(BuildContext context) {
    if (keyForm.currentState!.validate()) {
      context.read<RegisterBloc>().add(ERegisterPageRegister(
          email: emailCtl.text,
          username: usernamelCtl.text,
          phone: phoneCtl.text,
          pass: pass1Ctl.text,
          address: addressCtl.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.grey, spreadRadius: 1)
          ]),
      child: Form(
        key: keyForm,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            children: [
              TextFormField(
                controller: emailCtl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: emailValidate,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: usernamelCtl,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: inputlValidate,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phoneCtl,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: inputlValidate,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: addressCtl,
                decoration: const InputDecoration(labelText: 'Address'),
                keyboardType: TextInputType.phone,
                validator: inputlValidate,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: pass1Ctl,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: inputlValidate,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: pass2Ctl,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                validator: confirmPass,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () => clickSignUp(context),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'popins1',
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
