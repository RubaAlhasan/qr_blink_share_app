// Stores & refreshes authentication tokens securely.

import 'package:dio/dio.dart';
import 'package:qr_blink_share_app/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  static Future<String?> refreshToken() async {
    final Dio dio = Dio();
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) return null;

    try {
      final response = await dio.post(
        "$authUrl/connect/token",
        data: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
          'client_id': 'QR_BlinkShare_App',
          'scope':'offline_access QR_BlinkShare'
        },
      );

      if (response.statusCode == 200) {
        await saveTokens(response.data['access_token'], response.data['refresh_token']);
        return response.data['access_token'];
      }
    } catch (e) {
      await clearTokens();
    }
    return null;
  }
}
