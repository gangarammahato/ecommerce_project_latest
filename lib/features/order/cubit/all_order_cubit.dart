import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/order/resources/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllOrderCubit extends Cubit<CommonState> {
  final OrderRepository orderRepository;
  AllOrderCubit({required this.orderRepository}) : super(CommonInitialState());

  fetchAllOrder() async {
    emit(CommonLoadingState());
    final res = await orderRepository.fetchOrders();

    emit(res.fold((err) => CommonErrorState(message: err), 
    (data) => CommonSuccessState(item: data),
    ),
    );
  }
}
