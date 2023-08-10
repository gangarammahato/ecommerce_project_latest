import 'dart:convert';

import 'package:ecommerce_project/features/auth/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static const String _tokenKey = "appToken";
  static const String _userModelKey = "userModel";

  static Future<void> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, token);
  }

  static Future<String> getToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_tokenKey) ?? "";
  }

  static Future<void> removeToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_tokenKey);
  }

  static Future<void> saveUserModel(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final mapUserModel = userModel.toMap();
    final String encodedData = json.encode(mapUserModel);
    sharedPreferences.setString(_userModelKey, encodedData);
  }

  static Future<UserModel?> getUserModel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final encodedData = sharedPreferences.getString(_userModelKey);
    if (encodedData != null) {
      final decodedData = Map<String, dynamic>.from(json.decode(encodedData));
      final userModel = UserModel.fromJson(decodedData);
      return userModel;
    } else {
      return null;
    }
  }

  static Future<void> removeUserModel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_userModelKey);
  }
}
