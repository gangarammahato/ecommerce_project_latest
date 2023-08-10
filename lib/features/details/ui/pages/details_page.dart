import 'package:ecommerce_project/features/cart/cubit/addtocart_cubit.dart';
import 'package:ecommerce_project/features/details/cubit/product_details_cubit.dart';
import 'package:ecommerce_project/features/details/ui/widgets/details_widgets.dart';
import 'package:ecommerce_project/features/home/resources/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  final String productId;
  const DetailsPage({
    super.key, required this.productId
    //required this.productId
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductDetailCubit(
              productRepository: context.read<ProductRepository>()),
        ),
        BlocProvider(
          create: (context) => AddToCartCubit(
            productRepository: context.read<ProductRepository>()),
        ),
      ],
      child: DetailsWidgets(
          productId: productId,
          ),
    );
  }
}
