import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_project/common/constants.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/order/model/order_model.dart';

class OrderRepository {
  final UserRepository userRepository;

  OrderRepository({required this.userRepository});

  final List<OrderModel> _orderModel =[];

  List<OrderModel> get orderModel => _orderModel;

  Future<Either<String, void>> createOrder({
    required String fullName,
    required String address,
    required String city,
    required String phone,
  }) async {
    try {
      final Dio dio = Dio();
      final Map<String, dynamic> body = {
        "address": address,
        "city": city,
        "phone": phone,
        "full_name": fullName,
      };

      final _ = await dio.post(
        "${Constants.baseUrl}/orders",
        data: body,
        options: Options(
          headers: {"Authorization": "Bearer ${userRepository.token}"},
        ),
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "ubable to create order");
    } catch (e) {
      return Left(e.toString());
    }
  }


  Future<Either<String, List<OrderModel>>> fetchOrders() async {
    try {
      final Dio dio = Dio();
      final Map<String, dynamic> headers = {
        "Authorization": "Bearer ${userRepository.token}"
      };
      final res = await dio.get("${Constants.baseUrl}/orders",
          options: Options(
            headers: headers,
          ));
      final temp = List.from(res.data["results"])
          .map((e) => OrderModel.fromMap(e))
          .toList();
      _orderModel.clear();
      _orderModel.addAll(temp);
      return Right(_orderModel);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to fetch Product");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
