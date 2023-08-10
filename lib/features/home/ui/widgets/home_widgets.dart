import 'dart:async';

import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/card/custom_product_card.dart';
import 'package:ecommerce_project/features/details/ui/pages/details_page.dart';
import 'package:ecommerce_project/features/home/cubit/fetch_product_event.dart';
import 'package:ecommerce_project/features/home/cubit/product_cubit.dart';
import 'package:ecommerce_project/features/home/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidgets extends StatefulWidget {
  const HomeWidgets({
    super.key,
  });

  @override
  State<HomeWidgets> createState() => _HomeWidgetsState();
}

class _HomeWidgetsState extends State<HomeWidgets> {
  Completer<bool> _refreshCompleter = Completer<bool>();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductCubit, CommonState>(
        listener: (context, state) {
          if (state is! CommonLoadingState &&
              _refreshCompleter.isCompleted == false) {
            _refreshCompleter.complete(true);
          }
        },
        buildWhen: (previous, current) {
          if (current is CommonLoadingState) {
            return current.showLoading;
          } else {
            return true;
          }
        },
        builder: (context, state) {
          if (state is CommonErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CommonSuccessState<List<Product>>) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels >
                        (notification.metrics.maxScrollExtent / 2) &&
                    _scrollController.position.userScrollDirection ==
                        ScrollDirection.reverse) {
                  context.read<ProductCubit>().add(LoadMoreProductEvent());
                  print("50% percent covered");
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  _refreshCompleter = Completer<bool>();
                  context.read<ProductCubit>().add(RefreshProductEvent());
                  _refreshCompleter.future;
                },
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.item.length,
                    itemBuilder: (context, index) {
                      return CustomProductCard(
                        image: state.item[index].image,
                        name: state.item[index].name,
                        brandName: state.item[index].brand,
                        price: "Rs. ${state.item[index].price}",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                productId: state.item[index].id,
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
