import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/button/custom_rounded_buttom.dart';
import 'package:ecommerce_project/common/card/cart_card.dart';
import 'package:ecommerce_project/common/utils/snakbar_utils.dart';
import 'package:ecommerce_project/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_project/features/cart/cubit/update_cart_quantity_cubit.dart';
import 'package:ecommerce_project/features/cart/model/cart_model.dart';
import 'package:ecommerce_project/features/checkout/ui/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CartWidgets extends StatefulWidget {
  const CartWidgets({super.key});

  @override
  State<CartWidgets> createState() => _CartWidgetsState();
}

class _CartWidgetsState extends State<CartWidgets> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: BlocListener<UpdateCartQuantityCubit, CommonState>(
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
            if (state is CommonErrorState) {
              SnakbarUtils.showMessage(
                  context: context, message: state.message);
            }
          },
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: BlocBuilder<AllCartCubit, CommonState>(
                  builder: (context, state) {
                    if (state is CommonErrorState) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else if (state is CommonSuccessState<List<CartModel>>) {
                      if (state.item.isNotEmpty) {
                        return ListView.builder(
                          itemCount: state.item.length,
                          itemBuilder: ((context, index) {
                            return CartCard(
                              cartModel: state.item[index],
                            );
                          }),
                        );
                      } else {
                        return Column(
                          // mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Image.asset(
                              "assets/images/emptycart.png",
                              height: 200,
                              width: 200,
                              color: Colors.black,
                            )),
                            const Text("No any Items in Cart"),
                          ],
                        );
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BlocSelector<AllCartCubit, CommonState, bool>(
          selector: (state) {
            if (state is CommonSuccessState<List<CartModel>> &&
                state.item.isNotEmpty) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            if (state == false) {
              return Container(height: 1);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                         BorderRadius.vertical(top: Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, -3),
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocSelector<AllCartCubit, CommonState, String>(
                        selector: (state) {
                          if (state is CommonLoadingState) {
                            return "Loading";
                          } else if (state
                              is CommonSuccessState<List<CartModel>>) {
                            return state.item
                                .fold<double>(
                                    0,
                                    (pv, e) =>
                                        pv + (e.quantity * e.product.price))
                                .toString();
                          } else {
                            return "Unknow";
                          }
                        },
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Text(
                              "Total Cost: Rs. $state",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                CustomRoundedButton(
                  title: "Checkout",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CheckoutPage()));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
