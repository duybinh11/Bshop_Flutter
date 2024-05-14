import 'package:do_an2_1/BuyOrderDetail/bloc/buy_order_detail_bloc.dart';
import 'package:do_an2_1/OrderDetailPage/bloc/order_detail_bloc.dart';
import 'package:do_an2_1/ProfilePage/bloc/profile_bloc.dart';
import 'package:do_an2_1/RateItemPage/ui/RateItemPage.dart';
import 'package:do_an2_1/RegisterPage/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Api/ApiAuth.dart';
import 'BuyOrderDetail/ui/BuyOrderDetailPage.dart';
import 'CartPage/bloc/cart_bloc.dart';
import 'HomePage/bloc/home_bloc.dart';
import 'ItemDetail/bloc/item_detail_bloc.dart';
import 'ItemDetail/ui/ItemDetailPage.dart';
import 'Login/bloc/login_bloc.dart';
import 'Login/ui/LoginPage.dart';
import 'ManagerPageHome/ui/ManagerPageHome.dart';
import 'Model/UserModel.dart';
import 'OrderDetailPage/uiCart/OrderDetailPage.dart';
import 'OrderPage/bloc/order_page_bloc.dart';
import 'RegisterPage/ui/RegisterPage.dart';
import 'SimpleBlocObserver .dart';
import 'VnPayPage.dart/ui/VnPayPage.dart';

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
  void initState() {
    super.initState();
  }

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
        BlocProvider<ItemDetailBloc>(
          create: (context) => ItemDetailBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<OrderDetailBloc>(
          create: (context) => OrderDetailBloc(),
        ),
        BlocProvider<OrderPageBloc>(
          create: (context) => OrderPageBloc(),
        ),
        BlocProvider<BuyOrderDetailBloc>(
          create: (context) => BuyOrderDetailBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.routeName: (context) => const LoginPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          ManagerPageHome.routeName: (context) => const ManagerPageHome(),
          ItemDetailPage.routeName: (context) => const ItemDetailPage(),
          VnPayPage.routeName: (context) => const VnPayPage(),
          OrderDetailPage.routeName: (context) => const OrderDetailPage(),
          BuyOrderDetailPage.routeName: (context) => const BuyOrderDetailPage(),
          RateItemPage.routeName: (context) => const RateItemPage()
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
                  context.read<LoginBloc>().userModel = snapshot.data;
                  return const ManagerPageHome();
                }
              }
              return const Scaffold(body: Text("isd"));
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

AlertDialog showdialogLoading(BuildContext context) {
  return const AlertDialog(
    content: SizedBox(
        height: 100,
        width: 100,
        child: Center(child: CircularProgressIndicator())),
  );
}

class EmptyCustom extends StatelessWidget {
  const EmptyCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/img/empty_box.png');
  }
}
