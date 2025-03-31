import 'package:flutter/material.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/signup_screen.dart';
// import 'features/auth/presentation/login_page.dart';
// import 'features/auth/presentation/signup_page.dart';
// import 'features/qr/presentation/qr_generator_page.dart';
// import 'features/qr/presentation/qr_history_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      // case '/qr':
      //   return MaterialPageRoute(builder: (_) => QRGeneratorPage());
      // case '/history':
      //   return MaterialPageRoute(builder: (_) => QRHistoryPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
