import 'package:do_an2_1/Login/bloc/login_bloc.dart';
import 'package:do_an2_1/Model/ItemOrderModel.dart';
import 'package:do_an2_1/RateItemPage/bloc/rate_item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class RateItemPage extends StatefulWidget {
  static const routeName = '/RateItemPage';
  const RateItemPage({super.key});

  @override
  State<RateItemPage> createState() => _RateItemPageState();
}

class _RateItemPageState extends State<RateItemPage> {
  late ItemOrderModel itemOrder;

  final commentCtl = TextEditingController();
  late int idUser;
  final keyForm = GlobalKey<FormState>();
  final rateBloc = RateItemBloc();

  @override
  void didChangeDependencies() {
    idUser = context.read<LoginBloc>().userModel!.id;
    Map<String, dynamic> mapData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    itemOrder = mapData['item_order'];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    rateBloc.close();
    commentCtl.dispose();
    super.dispose();
  }

  String? validateComment(String? value) {
    if (value!.isEmpty) {
      return 'Vui lòng đánh gia';
    }
    return null;
  }

  void clickRate() {
    if (keyForm.currentState!.validate()) {
      rateBloc.add(ERateItemAdd(
          idUser: idUser,
          idOrder: itemOrder.id,
          idItem: itemOrder.item.id,
          rateNum: rateNum,
          comment: commentCtl.text));
    }
  }

  double rateNum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá'),
      ),
      body: BlocBuilder<RateItemBloc, RateItemState>(
        bloc: rateBloc,
        builder: (context, state) {
          if (state is SRateItemLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SRateItemErorr) {
            return const Center(child: Text('erorr'));
          }
          if (state is SRateItemSuccess) {
            return const Center(child: Text('thanh conong'));
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  RatingBar.builder(
                      allowHalfRating: true,
                      itemBuilder: (context, index) => const Icon(
                            size: 16,
                            Icons.star,
                            color: Colors.amber,
                          ),
                      onRatingUpdate: (rating) {
                        rateNum = rating;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: keyForm,
                    child: TextFormField(
                      controller: commentCtl,
                      validator: validateComment,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.comment_bank,
                            color: Colors.blue,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => clickRate(),
                      child: const Text(
                        'Đánh giá',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
