import 'dart:async';

import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/cart/cubit/update_cart_quantity_cubit.dart';
import 'package:ecommerce_project/features/cart/model/cart_model.dart';
import 'package:ecommerce_project/features/cart/resources/cart_repository.dart';
import 'package:ecommerce_project/features/checkout/cubit/create_order_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCartCubit extends Cubit<CommonState> {
  final CartRepository cartRepository;
  final UpdateCartQuantityCubit updateCartQuantityCubit;
  //final AddToCartCubit addToCartCubit;

  final CreateOrderCubit createOrderCubit;

  StreamSubscription? orderSubscription;

  StreamSubscription? updateSubscription;

  AllCartCubit({
    required this.createOrderCubit,
    required this.updateCartQuantityCubit,
    required this.cartRepository,
  }) : super(CommonInitialState()) {
    updateSubscription = updateCartQuantityCubit.stream.listen((event) {
      if (event is CommonSuccessState<CartModel>) {
        emit(CommonLoadingState());
        emit(CommonSuccessState<List<CartModel>>(item: cartRepository.carts));
      }
    });

    orderSubscription = createOrderCubit.stream.listen((event) {
      if (event is CommonSuccessState) {
        fetchCart();
      }
    });
  }

  fetchCart() async {
    emit(CommonLoadingState());
    final res = await cartRepository.getAllCart();
    emit(res.fold((err) => CommonErrorState(message: err),
        (data) => CommonSuccessState<List<CartModel>>(item: data)));
  }

  @override
  Future<void> close() {
    updateSubscription?.cancel();
    orderSubscription?.cancel();
    return super.close();
  }
}
