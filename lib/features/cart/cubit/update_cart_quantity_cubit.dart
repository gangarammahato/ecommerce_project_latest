import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/cart/model/cart_model.dart';
import 'package:ecommerce_project/features/cart/resources/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateCartQuantityCubit extends Cubit<CommonState> {
  final CartRepository cartRepository;
  UpdateCartQuantityCubit({required this.cartRepository})
      : super(CommonInitialState());

  update({
    required String cartId,
    required int quantity,
  }) async {
    emit(CommonLoadingState());
    final res = await cartRepository.updateCartquantity(
        cartId: cartId, quantity: quantity);

    emit((res.fold((err) => CommonErrorState(message: err),
        (data) => CommonSuccessState<CartModel>(item: data))));
  }
}
