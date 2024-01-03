import 'package:do_an2_1/Login/bloc/login_bloc.dart';
import 'package:do_an2_1/OrderDetailPage/bloc/order_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

import '../bloc/vn_pay_bloc.dart';

class VnPayPage extends StatefulWidget {
  static const routeName = '/VnPayPage';
  const VnPayPage({super.key});

  @override
  State<VnPayPage> createState() => _VnPayPageState();
}

class _VnPayPageState extends State<VnPayPage> {
  bool isAddVnpayCalled = false;
  DateFormat format = DateFormat("yyyyMMddHHmmss");
  final bloc = VnPayBloc();

  void postMoney(BuildContext context) {
    int money = context.read<OrderDetailBloc>().totalMoney;
    bloc.add(EVnpayGetUrl(money: money));
  }

  void buyItem(BuildContext context) {
    int idUser = context.read<LoginBloc>().userModel!.id;
    final orderDetailBloc = context.read<OrderDetailBloc>();
    bloc.add(EVnPayAddVnpayBuyItem(
        idUser: idUser, orderDetailBloc: orderDetailBloc));
  }

  void addVnpay(Map<String, dynamic> map, int isPayment) {
    if (!isAddVnpayCalled) {
      isAddVnpayCalled = true;
      if (map['vnp_TransactionStatus'] == '00' ||
          map['vnp_TransactionStatus'] == '02') {
        int id = int.parse(map['vnp_TxnRef']);
        int amount = int.parse(map['vnp_Amount']) ~/ 100;
        String bankCode = map['vnp_BankCode'] as String;
        isPayment == 1 ? bloc.add(EVnpayUpdateBill()) : null;
        bloc.add(EVnPayAddVnpay(
          id: id,
          money: amount,
          bankCode: bankCode,
          isPayMent: isPayment,
        ));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    bloc.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('vnpay')),
      body: BlocBuilder<VnPayBloc, VnPayState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is SVnPayLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SVnPayGetUrlErorr) {
            return const Text('loi SVnPayGetUrlErorr');
          }
          if (state is SVnPayPaymentSuccess) {
            return const Text('Thanh toan thanh cong');
          }
          if (state is SVnPayPaymentNotPay) {
            return const Text('ban chua thanh toan');
          }
          if (state is SVnPayPaymentErorr) {
            return const Text('loi SVnPayPaymentErorr');
          }
          if (state is SVnpayGetUrlSuccesss) {
            VNPAYFlutter.instance.show(
              paymentUrl: state.url,
              onPaymentSuccess: (map) {
                addVnpay(map, 1);
              },
              onPaymentError: (map) {
                addVnpay(map, 0);
              },
            );
          }
          return Center(
            child: ElevatedButton(
                onPressed: () {
                  buyItem(context);
                  postMoney(context);
                },
                child: const Text(
                  'Thanh Toán',
                  style: TextStyle(color: Colors.white),
                )),
          );
        },
      ),
    );
  }
}
