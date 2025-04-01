import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://blinkshare.net/connect/token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'password',
          'username': email,
          'password': password,
          'client_id': 'QR_BlinkShare_App'
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['access_token'];
      }
    } catch (e) {
      print("Login failed: $e");
    }
    return null;
  }
}
