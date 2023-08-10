import 'package:ecommerce_project/features/home/cubit/fetch_product_event.dart';
import 'package:ecommerce_project/features/home/cubit/product_cubit.dart';
import 'package:ecommerce_project/features/home/resources/product_repository.dart';
import 'package:ecommerce_project/features/home/ui/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  //String product;
    const HomePage({super.key, 
    //required this.product
    });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(
        productRepository: RepositoryProvider.of<ProductRepository>(context),
      )..add(FetchProductEvent()),
      child:  const HomeWidgets(
       // product: product,
      ),
    );
  }
}
