import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/blocs/ebook/ebook_detail_bloc.dart';
import 'package:stock_careers/blocs/ebook/ebook_detail_event.dart';
import 'package:stock_careers/presentation/screens/auth/forget_password.dart';
import 'package:stock_careers/presentation/screens/blog_detail_screen.dart';
import 'package:stock_careers/presentation/screens/blog_screen.dart';
import 'package:stock_careers/presentation/screens/course_screen.dart';
import 'package:stock_careers/presentation/screens/ebook_detail_screen.dart';
import 'package:stock_careers/presentation/screens/ebook_screen.dart';
import 'package:stock_careers/presentation/screens/home_screen.dart';
import 'package:stock_careers/presentation/screens/login_screen.dart';
import 'package:stock_careers/presentation/screens/onboarding.dart';
import 'package:stock_careers/presentation/screens/profile/edit_profile.dart';
import 'package:stock_careers/presentation/screens/profile_screen.dart';
import 'package:stock_careers/presentation/screens/signup_screen.dart';
import 'package:stock_careers/presentation/screens/splash_screen_wrapper.dart';
import 'package:stock_careers/utils/blogs_utils.dart';

class AppRoutes {
  static const String signUp = '/signup';
  static const String login = '/login';
  static const String home = '/home';
  static const String course = '/course';
  static const String profile = '/profile';
  static const String onboarding = '/onboarding';
  static const String forgetPassword = '/forget_password';
  static const String splash = '/splash';
  static const String blog = '/blog';
  static const String blogDetail = '/blogDetail';
  static const String ebook = '/ebook';
  static const String ebookDetail = '/ebookDetail';
  static const String editProfile = '/editProfile';

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
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreenWrapper());
      case blog:
        return MaterialPageRoute(builder: (_) => BlogScreen());
      case blogDetail:
        final args = settings.arguments;
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => BlogDetailScreen(blogId: args),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No blog ID provided')),
          ),
        );
      case ebook:
        return MaterialPageRoute(builder: (_) => const EbookScreen());
      case ebookDetail:
        final args = settings.arguments;
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => EbookDetailBloc()..add(FetchEbookDetail(args)),
              child: EbookDetailScreen(ebookId: args),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No ebook ID provided')),
          ),
        );
      case editProfile:
        return MaterialPageRoute(builder: (_) => EditProfile());
      default:
  if (settings.name != null && settings.name!.startsWith('/blog-details/')) {
    final slug = settings.name!.split('/').last;

    return MaterialPageRoute(
      builder: (_) => FutureBuilder<String?>(
        future: fetchBlogIdFromSlug(slug),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasData && snapshot.data != null) {
            return BlogDetailScreen(blogId: snapshot.data!);
          } else {
            return const Scaffold(body: Center(child: Text('Blog not found')));
          }
        },
      ),
    );
  }

  return MaterialPageRoute(
    builder: (_) => const Scaffold(body: Center(child: Text('No route defined'))),
  );

    }
  }
}
