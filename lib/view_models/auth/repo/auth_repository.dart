import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final Dio _dio = Dio();

  Future<String?> loginUser(String username, String password) async {
    try {
      final response = await _dio.post(
        'https://dummyjson.com/auth/login',
        data: {"username": username, "password": password},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      log("Response Data: ${response.data}");

      if (response.statusCode == 200 && response.data != null) {
        // Use 'accessToken' instead of 'token'
        String? token = response.data['accessToken'];

        if (token != null) {
          await saveToken(token);
          return token;
        } else {
          log("Error: accessToken is null");
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log("Error Response: ${e.response?.data}");
      } else {
        log("Dio Error: ${e.message}");
      }
    } catch (e) {
      log("Unexpected Error: $e");
    }
    return null;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') != null;
  }
}
