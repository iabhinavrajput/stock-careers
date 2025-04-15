import 'package:flutter/material.dart';
import 'package:stock_careers/presentation/screens/course_screen.dart';
import 'package:stock_careers/presentation/screens/home_screen.dart';
import 'package:stock_careers/presentation/screens/login_screen.dart';
import 'package:stock_careers/presentation/screens/profile_screen.dart';
import 'package:stock_careers/presentation/screens/signup_screen.dart';

class AppRoutes {
  static const String signUp = '/signup';
  static const String login = '/login';
  static const String home = '/home';
  static const String course = '/course';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case course:
        return MaterialPageRoute(builder: (_) => const CourseScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}
