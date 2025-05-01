import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_careers/blocs/auth/forget_password/forgot_password_bloc.dart';
import 'package:stock_careers/blocs/course/course_bloc.dart';
import 'package:stock_careers/data/services/course_service.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/user/user_bloc.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(); // Declare the navigator key globally

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'access_token');
  print("Token: $token");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthService(Dio()))),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(
            create: (context) => ForgotPasswordBloc(AuthService(
                Dio()))), // Add ForgotPasswordBloc provider
        // 👈 This line is missing in your code
        BlocProvider(create: (context) => AuthBloc(AuthService(Dio()))),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => CourseBloc(CourseService())),
BlocProvider<UserBloc>(
      create: (context) => UserBloc(),)
      ],
      child: MyApp(isLoggedIn: token != null),
    ));
  });
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _handleDeepLinks();
  }

  String slugify(String text) {
    return text
        .toLowerCase()
      // .replaceAll(RegExp(r'[^\w\s-]'), '') // remove special chars
      .replaceAll(RegExp(r'\s+'), '-')     // spaces to dashes
      .replaceAll(RegExp(r'-+'), '-');  
  }

  void _handleDeepLinks() async {
    // Cold start (when the app is launched from a link)
    final initialUri =
        await _appLinks.getInitialAppLink(); // use getInitialAppLink() instead
    if (initialUri != null) {
      _handleUri(initialUri);
    }

    // Foreground / Deep links (when the app is in the background or running)
    _appLinks.uriLinkStream.listen((uri) {
      _handleUri(uri);
    });
  }

  void _handleUri(Uri uri) {
    if (uri.host == 'stockcareers.com' &&
        uri.pathSegments.contains('blog-details')) {
      final slug = uri.pathSegments.last;
      // Navigate to the blog screen using your route name and pass the slug
      Navigator.of(navigatorKey.currentContext!).pushNamed(
        '/blog-details/$slug',
        arguments: slug,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          navigatorKey: navigatorKey, // Use the navigator key here
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
          themeMode: themeMode,
          initialRoute: widget.isLoggedIn ? AppRoutes.home : AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
