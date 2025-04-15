import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stock_careers/presentation/screens/onboarding.dart';

class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1000,
      splash: Image.asset(
        Theme.of(context).brightness == Brightness.dark
                              ?'assets/images/logo/stocks_careers_favicon_white.png'
                              :'assets/images/logo/stocks_careers_favicon_black.png',
      ),
      nextScreen:  OnboardingScreen(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
