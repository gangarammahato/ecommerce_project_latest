// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_project/features/cart/model/cart_model.dart';

class OrderModel {
  final String id;
  final String status;
  final int totalAmount;
  final String dateOrdered;
  final List<CartModel> carts;

  OrderModel(
      {required this.id,
      required this.status,
      required this.totalAmount,
      required this.carts,
      required this.dateOrdered});

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['_id'] as String,
      status: map['status'] as String,
      totalAmount: map['totalPrice'] as int,
      dateOrdered: map["dateOrdered"] as String,
      carts: List.from(map['orderItems'])
          .map<CartModel>(
            (x) => CartModel.fromMap(x as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
