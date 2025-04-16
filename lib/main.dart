import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stock_careers/blocs/theme/theme_cubit.dart';
import 'package:stock_careers/presentation/screens/onboarding.dart';
import 'package:stock_careers/presentation/screens/splash_screen_wrapper.dart';
import 'package:stock_careers/routes/app_route_generator.dart';
import 'package:stock_careers/utils/constants/app_theme.dart';
import 'package:stock_careers/utils/constants/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // String? token = await FirebaseMessaging.instance.getToken();
  // print("Firebase token is: $token");

  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system, // or ThemeMode.dark / ThemeMode.light

          home: const SplashScreenWrapper(),
          routes: AppRouteMap.routes, // 👈 Clean and centralized
        );
      },
    );
  }
}
