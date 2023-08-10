import 'package:ecommerce_project/features/order/cubit/all_order_cubit.dart';
import 'package:ecommerce_project/features/order/resources/order_repository.dart';
import 'package:ecommerce_project/features/order/ui/widgets/order_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllOrderCubit(
        orderRepository: context.read<OrderRepository>(),
      )..fetchAllOrder(),
      child: const OrderWidgets(),
    );
  }
}
