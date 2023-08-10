import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/order/resources/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderCubit extends Cubit<CommonState> {
  final OrderRepository orderRepository;
  CreateOrderCubit({required this.orderRepository})
      : super(CommonInitialState());

  create({
    required String fullName,
    required String address,
    required String city,
    required String phone,
  }) async {
    emit(CommonLoadingState());
    final res = await orderRepository.createOrder(
        fullName: fullName, address: address, city: city, phone: phone);

    emit(res.fold((err) => CommonErrorState(message: err), 
    (data) => CommonSuccessState(item: null),
    ),
    );
  }
}
