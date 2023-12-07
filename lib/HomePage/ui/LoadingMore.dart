import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class LoadingMore extends StatelessWidget {
  const LoadingMore({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        if (current is SHomeGetLoadMoreEmpty) {
          return true;
        }
        if (current is SHomeGetLoadingMore) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is SHomeGetLoadingMore) {
          return const SizedBox(
            width: double.infinity,
            height: 59,
            child: Center(
              child: SizedBox(child: CircularProgressIndicator()),
            ),
          );
        }
        if (state is SHomeGetLoadMoreEmpty) {
          return const Center(child: Text('hết dữ liệu'));
        }
        return const SizedBox();
      },
    );
  }
}
