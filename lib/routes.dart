import 'package:flutter/material.dart';
import 'package:sosyal_surucu/login_screen.dart';
import 'package:sosyal_surucu/signup_screen.dart';
import 'package:sosyal_surucu/home_screen.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Geçersiz route: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
