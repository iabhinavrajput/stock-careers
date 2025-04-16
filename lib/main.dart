import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_careers/blocs/course/course_bloc.dart';
import 'package:stock_careers/data/services/course_service.dart';
import 'blocs/auth/auth_bloc.dart';
import 'data/services/auth_service.dart';
import 'routes/app_routes.dart';
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

  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'access_token');
  print("Token: $token");

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthService())),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => CourseBloc(CourseService())),
      ],
      child: MyApp(isLoggedIn: token != null),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Stock Careers',
          debugShowCheckedModeBanner: false,

          theme: AppThemes.lightTheme.copyWith(
            textTheme:
                GoogleFonts.poppinsTextTheme(AppThemes.lightTheme.textTheme),
          ),
          darkTheme: AppThemes.darkTheme.copyWith(
            textTheme:
                GoogleFonts.poppinsTextTheme(AppThemes.darkTheme.textTheme),
          ),

          themeMode: themeMode, // controlled by ThemeCubit

          initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
          // OR if you’re using a static map of routes:
          // routes: AppRouteMap.routes,
        );
      },
    );

    //   },
    // );
  }
}
