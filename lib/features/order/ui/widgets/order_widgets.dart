import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/card/order_card.dart';
import 'package:ecommerce_project/features/order/cubit/all_order_cubit.dart';
import 'package:ecommerce_project/features/order/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderWidgets extends StatelessWidget {
  const OrderWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllOrderCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CommonSuccessState<List<OrderModel>>) {
            return ListView.builder(
                itemCount: state.item.length,
                itemBuilder: (context, index) {
                  return OrderCard(
                    order: state.item[index],
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
