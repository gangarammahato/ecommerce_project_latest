import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_project/common/constants.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/cart/model/cart_model.dart';

class CartRepository {
  final UserRepository userRepository;
  final List<CartModel> _carts = [];

  CartRepository({
    required this.userRepository,
  });

  List<CartModel> get carts => _carts;

  Future<Either<String, List<CartModel>>> getAllCart() async {
    try {
      final dio = Dio();
      // final Map<String, dynamic> header = {
      //   "Authorization": "Bearer ${userRepository.token}",
      // };
      final res = await dio.get("${Constants.baseUrl}/cart/",
          options: Options(
            headers: {
              "Authorization": "Bearer ${userRepository.token}",
            },
          ));
      final items = List.from(res.data["results"])
          .map((e) => CartModel.fromMap(e))
          .toList();
      _carts.clear();
      _carts.addAll(items);
      return Right(_carts);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to all cart");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CartModel>> updateCartquantity({
    required String cartId,
    required int quantity,
  }) async {
    try {
      final dio = Dio();
      // final Map<String, dynamic> header = {
      //   "Authorization": "Bearer ${userRepository.token}",
      // };
      final res = await dio.put("${Constants.baseUrl}/cart/$cartId",
          data: {
            "quantity": quantity,
          },
          options: Options(
            headers: {
              "Authorization": "Bearer ${userRepository.token}",
            },
          ));
      final items = CartModel.fromMap(res.data["results"]);
      final index = _carts.indexWhere((element) => element.id == items.id);
      if (index != -1) {
        _carts[index] = items;
      }

      return Right(items);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to all cart");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
