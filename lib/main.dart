import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Api/ApiAuth.dart';
import 'HomePage/bloc/home_bloc.dart';
import 'Login/bloc/login_bloc.dart';
import 'Login/ui/LoginPage.dart';
import 'ManagerPageHome/ui/ManagerPageHome.dart';
import 'Model/UserModel.dart';
import 'SimpleBlocObserver .dart';

void main() {
  runApp(const MyApp());
  Bloc.observer = const SimpleBlocObserver();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        // BlocProvider<ItemDetailBloc>(
        //   create: (context) => ItemDetailBloc(),
        // ),
        // BlocProvider<CartBloc>(
        //   create: (context) => CartBloc(),
        // ),
        // BlocProvider<CartOrderBloc>(
        //   create: (context) => CartOrderBloc(),
        // ),
        // BlocProvider<OrderBloc>(
        //   create: (context) => OrderBloc(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.routerName: (context) => const LoginPage(),
          // RegisterPage.routeName: (context) => const RegisterPage(),
          // ManagerPageHome.routeName: (context) => const ManagerPageHome(),
          // ItemDetailPage.routeName: (context) => const ItemDetailPage(),
          // VnPayPage.routeName: (context) => const VnPayPage(),
          // CartOrderPage.routeName: (context) => const CartOrderPage(),
          // VnPayOrderPage.routeName: (context) => const VnPayOrderPage()
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.blue),
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: FutureBuilder<dynamic>(
            future: ApiAuth.loginToken(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data is bool) {
                  return const LoginPage();
                } else if (snapshot.data is UserModel) {
                  context.read<LoginBloc>().userModel =
                      snapshot.data as UserModel;
                  return const ManagerPageHome();
                }
              }
              return const Scaffold(body: SizedBox());
            }),
      ),
    );
  }
}

AlertDialog showdialogCustom(
    BuildContext context, String title, String content) {
  return AlertDialog(
    title: Text(
      title,
      style: const TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
    ),
    content: Text(
      content,
      style: const TextStyle(fontSize: 15),
    ),
    actions: [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Text(
          'Đóng',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
    ],
  );
}
