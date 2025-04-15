import 'package:flutter/material.dart';
import 'package:stock_careers/presentation/screens/auth/forget_password.dart';
import 'package:stock_careers/presentation/screens/course_screen.dart';
import 'package:stock_careers/presentation/screens/home_screen.dart';
import 'package:stock_careers/presentation/screens/login_screen.dart';
import 'package:stock_careers/presentation/screens/onboarding.dart';
import 'package:stock_careers/presentation/screens/profile_screen.dart';
import 'package:stock_careers/presentation/screens/signup_screen.dart';
import 'package:stock_careers/presentation/screens/splash_screen_wrapper.dart';

class AppRoutes {
  static const String signUp = '/signup';
  static const String login = '/login';
  static const String home = '/home';
  static const String course = '/course';
  static const String profile = '/profile';
  static const String onboarding = '/onboarding';
    static const String forgetPassword = '/forget_password';
        static const String splash = '/splash';



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
          case onboarding:
        return MaterialPageRoute(builder: (_) =>  OnboardingScreen());
          case forgetPassword:
        return MaterialPageRoute(builder: (_) =>  ForgotPasswordScreen());
           case splash:
        return MaterialPageRoute(builder: (_) =>  SplashScreenWrapper());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}
