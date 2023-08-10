import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_project/common/constants.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/home/model/product_model.dart';

class ProductRepository {
  final UserRepository userRepository;
  final List<Product> _items = [];

  ProductRepository({required this.userRepository});

  List<Product> get items => _items;

  int _currentPage = 1;
  int _totalProductCount = -1;

  Future<Either<String, List<Product>>> fetchProducts(
      {bool isLoadMore = false}) async {
    try {
      if (_items.length == _totalProductCount && isLoadMore) {
        return Right(_items);
      }
      if (isLoadMore) {
        _currentPage++;
      } else {
        _currentPage = 1;
        _items.clear();
        _totalProductCount = -1;
      }
      final Dio dio = Dio();
      final Map<String, dynamic> headers = {
        "Authorization": "Bearer ${userRepository.token}"
      };
      final res = await dio.get("${Constants.baseUrl}/products",
          queryParameters: {
            "page": _currentPage,
          },
          options: Options(
            headers: headers,
          ));
      final temp = List.from(res.data["results"])
          .map((e) => Product.fromMap(e))
          .toList();
      //temp.shuffle();
      _totalProductCount = res.data["total"];
      _items.addAll(temp);
      return Right(_items);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to fetch Product");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Product>> fetchProductDetails(
      {required String productId}) async {
    try {
      final dio = Dio();
      final Map<String, dynamic> header = {
        "authorization": "Bearer ${userRepository.token}",
      };
      final response = await dio.get("${Constants.baseUrl}/products/$productId",
          options: Options(
            headers: header,
          ));
      final items = Product.fromMap(response.data["results"]);
      return Right(items);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to fetch Products");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> addToCart({required String productId}) async {
    try {
      final dio = Dio();
      final Map<String, dynamic> header = {
        "authorization": "Bearer ${userRepository.token}",
      };

      final _ = await dio.post("${Constants.baseUrl}/cart",
          options: Options(headers: header),
          data: {
            "quantity": 1,
            "product": productId,
          });
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to add to cart");
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Future<Either<String,CartModel>>getAllCart(
  //     ) async {
  //   try {
  //     final dio = Dio();
  //     final Map<String, dynamic> header = {
  //       "authorization": "Bearer ${userRepository.token}",
  //     };
  //     final response = await dio.get("${Constants.baseUrl}/cart/",
  //         options: Options(
  //           headers: header,
  //         ));
  //     final items = CartModel.fromMap(response.data["results"]);
  //     return Right(items);
  //   } on DioException catch (e) {
  //     return Left(e.response?.data["message"] ?? "Unable to all cart");
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }
}
