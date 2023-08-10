import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/home/model/product_model.dart';
import 'package:ecommerce_project/features/home/resources/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;
  ProductDetailCubit({required this.productRepository})
      : super(CommonInitialState());

  fetchProductDetails({required String productId}) async {
    emit(CommonLoadingState());
    final res =
        await productRepository.fetchProductDetails(productId: productId);
    emit(res.fold((err) => CommonErrorState(message: err), 
    (data) => CommonSuccessState<Product>(item: data)
    ));
  }
}
