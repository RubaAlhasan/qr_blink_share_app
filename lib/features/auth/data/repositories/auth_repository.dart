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

  Future<bool> logout() async {

    //https://blinkshare.net/api/account/logout

        try {
      final response = await _dio.get('/api/account/logout');
      if(response.statusCode == 200 || response.statusCode == 204){
      await TokenManager.clearTokens();
      return true;
      }
      else {
        return false;
      }
    } catch (e) {
      print("Registration Error: $e");
      return false;
    }
    
    
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
