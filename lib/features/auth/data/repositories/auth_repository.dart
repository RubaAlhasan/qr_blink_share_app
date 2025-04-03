import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/utils/token_manager.dart';


class AuthRepository {
  final Dio _dio = ApiClient.dio;

  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post('/connect/token', data: {
          'grant_type': 'password',
          'username': email,
          'password': password,
          'client_id': 'QR_BlinkShare_App',
          'scope':'offline_access QR_BlinkShare'
      },
          options: Options(
          headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
          },
        )
        );

      if (response.statusCode == 200) {
        await TokenManager.saveTokens(response.data['access_token'], response.data['refresh_token']);
        return true;
      }
    } catch (e) {
      print("Login Error: $e");
    }
    return false;
  }

  Future<void> logout() async {
    await TokenManager.clearTokens();
  }
  

    Future<bool> register({
    required String userName,
    required String emailAddress,
    required String password
  }) async {
    try {
      final response = await _dio.post('/api/account/register', data: {
        "userName": userName,
        "emailAddress": emailAddress,
        "password": password,
        "appName": "QR_BlinkShare_App",
      });

      return response.statusCode == 200;
    } catch (e) {
      print("Registration Error: $e");
      return false;
    }
  }
}
