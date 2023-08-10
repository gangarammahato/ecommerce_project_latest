import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/home/cubit/fetch_product_event.dart';
import 'package:ecommerce_project/features/home/model/product_model.dart';
import 'package:ecommerce_project/features/home/resources/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Bloc<ProductEvent, CommonState> {
  final ProductRepository productRepository;
  ProductCubit({required this.productRepository})
      : super(CommonInitialState()) {
    on<FetchProductEvent>((event, emit) async {
      emit(CommonLoadingState());
      final res = await productRepository.fetchProducts();

      emit(res.fold((err) => CommonErrorState(message: err),
          (data) => CommonSuccessState<List<Product>>(item: data)));
    });

    on<RefreshProductEvent>((event, emit) async {
      emit(CommonLoadingState(showLoading: false));
    final _ = await productRepository.fetchProducts();

    emit(CommonSuccessState<List<Product>>(item: productRepository.items));
    });


    on<LoadMoreProductEvent>((event, emit) async {
      emit(CommonLoadingState(showLoading: false));
    final _ = await productRepository.fetchProducts(isLoadMore: true);

    emit(CommonSuccessState<List<Product>>(item: productRepository.items));
    },
    transformer: droppable(),
    );
  }
}
