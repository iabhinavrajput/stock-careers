import 'package:flutter/material.dart';
import 'package:stock_careers/presentation/widgets/button/small_button.dart';
import 'package:stock_careers/routes/route_default.dart';
import 'package:stock_careers/utils/constants/colors.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Quick and easy\nlearning',
      'image': 'assets/images/onboarding/onboarding2.png',
      'description':
          'Easy and fast learning at any\ntime to help you improve various skill.'
    },
    {
      'title': 'Create your own study plan',
      'image': 'assets/images/onboarding/onboarding1.png',
      'description':
          'Study according to them study\nplan, make study more motivated'
    },
    {
      'title': 'Numerous\ncourses',
      'image': 'assets/images/onboarding/onboarding3.png',
      'description': 'Free courses for you to\nfind your way to learning'
    },
  ];

  // PageController to manage page transitions
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(onboardingData[index]['image']!, height: 300),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        onboardingData[index]['title']!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        onboardingData[index]['description']!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        onboardingData.length,
                        (index) => buildDot(index, context),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 40),
          _currentIndex == onboardingData.length - 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SmallButton(
                      text: 'Sign up',
                      onPressed: () {
                        // your logic
                        Navigator.pushNamed(context, AppRoutes.forgetPassword);
                      },
                      backgroundColor: AppColors.lightPrimary,
                      textColor: Colors.white,
                    ),
                    SmallButton(
                      text: 'Log In',
                      borderColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColors.grey
                              : AppColors.lightPrimary,
                      onPressed: () {
                        // your logic
                      },
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColors.grey
                              : Colors.white,
                      textColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : AppColors.lightPrimary,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _pageController.jumpToPage(onboardingData.length - 1);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : AppColors.lightPrimary,
                        ),
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     // Move to next page
                    //     _pageController.nextPage(
                    //       duration: Duration(milliseconds: 300),
                    //       curve: Curves.easeIn,
                    //     );
                    //   },
                    //   child: Text(
                    //     'Next',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                  ],
                ),
          SizedBox(height: 20),
        ],
      ),
    ));
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 5,
      width: _currentIndex == index ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _currentIndex == index ? AppColors.lightPrimary : Colors.grey,
      ),
    );
  }
}
