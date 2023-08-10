import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/button/custom_rounded_buttom.dart';
import 'package:ecommerce_project/common/utils/snakbar_utils.dart';
import 'package:ecommerce_project/features/cart/cubit/addtocart_cubit.dart';
import 'package:ecommerce_project/features/details/cubit/product_details_cubit.dart';
import 'package:ecommerce_project/features/home/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class DetailsWidgets extends StatefulWidget {
  final String productId;
  const DetailsWidgets({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<DetailsWidgets> createState() => _DetailsWidgetsState();
}

class _DetailsWidgetsState extends State<DetailsWidgets> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    context
        .read<ProductDetailCubit>()
        .fetchProductDetails(productId: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade400,
        ),
        body: BlocListener<AddToCartCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              setState(() {
                isLoading = true;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
            if (state is CommonSuccessState) {
              context
                  .read<ProductDetailCubit>()
                  .fetchProductDetails(productId: widget.productId);
              SnakbarUtils.showMessage(
                  context: context, message: "Product added to cart");
            } else if (state is CommonErrorState) {
              SnakbarUtils.showMessage(
                  context: context, message: state.message);
            }
          },
          child: BlocBuilder<ProductDetailCubit, CommonState>(
            builder: (context, state) {
              if (state is CommonErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is CommonSuccessState<Product>) {
                return Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        state.item.image,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 20, right: 14, left: 14),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.item.brand,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.item.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Rs ${state.item.price}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.item.description,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        bottomNavigationBar:
            BlocSelector<ProductDetailCubit, CommonState, bool>(
          selector: (state) {
            if (state is CommonSuccessState<Product>) {
              return !state.item.isInCart;
            }
            return false;
          },
          builder: (context, state) {
            if (state) {
              return Container(
                height: 60,
                color: Colors.white,
                child: CustomRoundedButton(
                    title: "+ Add to Cart",
                    onPressed: () {
                      context.read<AddToCartCubit>().add(widget.productId);
                    }),
              );
            } else {
              return Container(
                height: 1,
              );
            }
          },
        ),
      ),
    );
  }
}
