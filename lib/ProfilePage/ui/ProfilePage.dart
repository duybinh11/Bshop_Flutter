import 'package:do_an2_1/Login/bloc/login_bloc.dart';
import 'package:do_an2_1/Login/ui/LoginPage.dart';
import 'package:do_an2_1/Model/UserModel.dart';
import 'package:do_an2_1/ProfilePage/bloc/profile_bloc.dart';
import 'package:do_an2_1/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc profileBloc;
  late UserModel userModel;
  @override
  void initState() {
    profileBloc = context.read<ProfileBloc>();
    userModel = context.read<LoginBloc>().userModel!;
    super.initState();
  }

  void clickLogout(BuildContext context) {
    profileBloc.add(EProfilePageLogout());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is SProfilePageLogoutSuccess) {
          Navigator.pushNamed(context, LoginPage.routeName);
        }
        if (state is SProfilePageLogoutErorr) {
          showDialog(
            context: context,
            builder: (context) =>
                showdialogCustom(context, 'Message', 'Logout Erorr'),
          );
        }
      },
      buildWhen: (previous, current) {
        if (current is SProfilePageLoading) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is SProfilePageLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Stack(
              children: [
                Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                            radius: 60,
                            child: Image.asset('assets/img/avt.png'),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          userModel.email,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          userModel.username,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          userModel.phone,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    )),
                Positioned(
                    right: 10,
                    top: 50,
                    child: IconButton(
                        onPressed: () => clickLogout(context),
                        icon: const Icon(Icons.logout)))
              ],
            ),
          ],
        );
      },
    ));
  }
}
