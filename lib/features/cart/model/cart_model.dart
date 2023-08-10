
import 'package:ecommerce_project/features/home/model/product_model.dart';

class CartModel {
  String id;
  int quantity;
  Product product;
  CartModel({
    required this.id,
    required this.quantity,
    required this.product,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'quantity': quantity,
  //     'product': product.toMap(),
  //   };
  // }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['_id'] as String,
      quantity: map['quantity'] as int,
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
    );
  }
}
