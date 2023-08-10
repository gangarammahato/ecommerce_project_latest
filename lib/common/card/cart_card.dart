import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/cart/cubit/update_cart_quantity_cubit.dart';
import 'package:ecommerce_project/features/cart/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCard extends StatefulWidget {
  final CartModel cartModel;
  // final String image;
  // final String name;
  // final String price;
  const CartCard({
    super.key,
    required this.cartModel,
    // required this.image,
    // required this.name,
    // required this.price
  });

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _quantity = widget.cartModel.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCartQuantityCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonSuccessState<CartModel> &&
            state.item.id == widget.cartModel.id) {
          _quantity = state.item.quantity;
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 20,
        ),
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade400,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.cartModel.product.image,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.cartModel.product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rs. ${widget.cartModel.product.price}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                 const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      IconButton(
                        splashRadius: 10.0,
                        onPressed: () {
                          if (_quantity > 1) {
                            context.read<UpdateCartQuantityCubit>().update(
                                  cartId: widget.cartModel.id,
                                  quantity: _quantity - 1,
                                );
                          }
                        },
                        icon: const Icon(
                          Icons.remove,
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        splashRadius: 10.0,
                        onPressed: () {
                          context.read<UpdateCartQuantityCubit>().update(
                                cartId: widget.cartModel.id,
                                quantity: _quantity + 1,
                              );
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
