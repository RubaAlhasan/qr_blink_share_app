// Handles API requests with error handling & interceptors for refreshing tokens.

import 'package:dio/dio.dart';
import 'package:qr_blink_share_app/core/constants/app_constants.dart';
import '../utils/token_manager.dart';

class ApiClient {
  static Dio dio = Dio(BaseOptions(
    baseUrl: '$baseUrl',
    connectTimeout: Duration(seconds: 100),
    receiveTimeout: Duration(seconds: 100),
    headers: {"Content-Type": "application/json"},
  ));

  static void setupInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await TokenManager.getAccessToken();
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          String? newToken = await TokenManager.refreshToken();
          if (newToken != null) {
            e.requestOptions.headers["Authorization"] = "Bearer $newToken";
            final clonedRequest = await dio.request(
              e.requestOptions.path,
              options: Options(
                method: e.requestOptions.method,
                headers: e.requestOptions.headers,
              ),
              data: e.requestOptions.data,
              queryParameters: e.requestOptions.queryParameters,
            );
            return handler.resolve(clonedRequest);
          }
        }
        return handler.next(e);
      },
    ));
  }
}
