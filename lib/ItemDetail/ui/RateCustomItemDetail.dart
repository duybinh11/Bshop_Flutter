import 'package:do_an2_1/RateStar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/item_detail_bloc.dart';

// ignore: must_be_immutable
class RateCustom extends StatefulWidget {
  RateCustom({super.key, required this.idItem});
  int idItem;

  @override
  State<RateCustom> createState() => _RateCustomState();
}

class _RateCustomState extends State<RateCustom> {
  @override
  void initState() {
    context.read<ItemDetailBloc>().add(EItemDetailRate(id: widget.idItem));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemDetailBloc, ItemDetailState>(
      builder: (context, state) {
        return Container(
          height: 400,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(5))),
          child: BlocBuilder<ItemDetailBloc, ItemDetailState>(
            builder: (context, state) {
              if (state is SItemDetailLoadingRate) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is SItemDetailRateEmpty) {
                return const Center(child: Text('rate empty'));
              }
              if (state is SItemDetailGetRate) {
                final listRate = state.listRate;
                return ListView.builder(
                  itemCount: listRate.length,
                  itemBuilder: (context, index) => ListTile(
                      leading: ClipOval(
                        child: CircleAvatar(
                          child: listRate[index].userModel.img != null
                              ? Image.network(listRate[index].userModel.img!)
                              : Image.asset('assets/img/user.png'),
                        ),
                      ),
                      title: Text(
                        listRate[index].userModel.username,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        listRate[index].comment,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: SizedBox(
                        height: double.infinity,
                        width: 100,
                        child: Column(
                          children: [
                            RateStar(
                                rateAvg: listRate[index].rateStar, fixSize: 15),
                            Text(
                              '${listRate[index].createdAt.day}/${listRate[index].createdAt.month}/${listRate[index].createdAt.year}',
                              style: const TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      )),
                );
              }
              return const Text('null');
            },
          ),
        );
      },
    );
  }
}
