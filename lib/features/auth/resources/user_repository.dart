import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_project/common/constants.dart';
import 'package:ecommerce_project/common/utils/shared_pref.dart';
import 'package:ecommerce_project/features/auth/model/user_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  UserModel? _userModel;
  String _token = "";
  UserModel? get userModel => _userModel;

  String get token => _token;

  Future initialize() async {
    final appToken = await SharedPrefUtils.getToken(token);
    final appUserModel = await SharedPrefUtils.getUserModel();
    _token = appToken;
    _userModel = appUserModel;
    if (_userModel != null) {
      initializeFirebaseCrashlytics(_userModel!);
    }
    print(_token);
  }

  initializeFirebaseCrashlytics(UserModel userModel) {
    FirebaseCrashlytics.instance.setUserIdentifier(userModel.id);
    FirebaseCrashlytics.instance.setCustomKey("email", userModel.email);
    FirebaseCrashlytics.instance.setCustomKey("name", userModel.name);
    FirebaseCrashlytics.instance.setCustomKey("id", userModel.id);
  }

  Future logout() async {
    await SharedPrefUtils.removeToken(token);
    await SharedPrefUtils.removeUserModel();
    _token = "";
    _userModel = null;
  }

  Future<Either<String, void>> signUp({
    required String name,
    required String phone,
    required String address,
    required String email,
    required String password,
    File? profile,
  }) async {
    try {
      final Dio dio = Dio();
      final Map<String, dynamic> body = {
        "name": name,
        "phone": phone,
        "address": address,
        "email": email,
        "password": password,
      };
      if (profile != null) {
        body["profile"] = await MultipartFile.fromFile(profile.path);
      }
      final _ = await dio.post(
        "${Constants.baseUrl}/auth/register",
        data: FormData.fromMap(body),
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "ubable to signup");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final dio = Dio();
      final Map<String, dynamic> body = {
        "email": email,
        "password": password,
      };

      final res = await dio.post(
        "${Constants.baseUrl}/auth/login",
        data: body,
      );
      final tempUser = UserModel.fromJson(res.data["results"]);
      final appToken = res.data["token"];

      _userModel = tempUser;
      _token = appToken;

      await SharedPrefUtils.saveToken(appToken);

      await SharedPrefUtils.saveUserModel(tempUser);

      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "unable to Login");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> facebookLogIn() async {
    try {
      await FacebookAuth.instance.logOut();
      final result = await FacebookAuth.instance.login(permissions: []);

      if (result.status == LoginStatus.success) {
        final String facebookToken = result.accessToken!.token;
        final dio = Dio();
        final Map<String, dynamic> body = {
          "token": facebookToken,
        };

        final res = await dio.post(
          "${Constants.baseUrl}/auth/login/social/facebook",
          data: body,
        );
        final tempUser = UserModel.fromJson(res.data["results"]);
        final appToken = res.data["token"];

        _userModel = tempUser;
        _token = appToken;
        initializeFirebaseCrashlytics(tempUser);

        await SharedPrefUtils.saveToken(appToken);

        await SharedPrefUtils.saveUserModel(tempUser);

        return const Right(null);
      } else {
        return Left(result.message ?? "Ubable to login with facebook");
      }

      return Left("test");
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "unable to Login");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> googleLogIn() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final result = await googleSignIn.signIn();

      if (result != null) {
        final googleToken = await result.authentication;
        final dio = Dio();
        final Map<String, dynamic> body = {
          "token": googleToken.accessToken,
        };

        final res = await dio.post(
          "${Constants.baseUrl}/auth/login/social/google",
          data: body,
        );
        final tempUser = UserModel.fromJson(res.data["results"]);
        final appToken = res.data["token"];

        _userModel = tempUser;
        _token = appToken;

        await SharedPrefUtils.saveToken(appToken);

        await SharedPrefUtils.saveUserModel(tempUser);

        return const Right(null);
      } else {
        return Left("Ubable to login with google");
      }

      return Left("test");
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "unable to Login");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
