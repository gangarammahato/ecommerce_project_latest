import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/home/resources/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;
  AddToCartCubit({required this.productRepository})
      : super(CommonInitialState());

  add( String productId) async {
    emit(CommonLoadingState());
    final res =
        await productRepository.addToCart(productId: productId);
    emit(res.fold((err) => CommonErrorState(message: err), 
    (data) => CommonSuccessState(item: null)
    ));
  }
}