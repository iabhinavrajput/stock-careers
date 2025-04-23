import 'package:flutter/material.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';
import 'package:stock_careers/utils/constants/textstyle.dart';
import 'course_screen.dart'; // Import your CourseScreen here

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate to different screens based on the index
    if (index == 1) {
      // If the Courses tab is tapped
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const CourseScreen()), // Navigate to the CourseScreen
      );
    } else if (index == 2) {
      // If the Profile tab is tapped
      // Handle navigation to the Profile screen
      Navigator.pushNamed(
          context, '/profile'); // Replace with your profile route
    }
    // You can handle other navigation logic for the Home and Profile tabs similarly
  }

  List<IconData> icons = [
    Icons.home,
    Icons.school,
    Icons.person,
  ];

  List<String> labels = [
    'Home',
    'Courses',
    'Profile',
  ];

  // Image URLs for the slider
  List<String> imgList = [
    'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png',
    'https://foundr.com/wp-content/uploads/2023/04/How-to-create-an-online-course.jpg.webp',
    'https://blogassets.leverageedu.com/blog/wp-content/uploads/2020/05/23151218/BA-Courses.png',
  ];

  @override
  Widget build(BuildContext context) {
    Dimensions.init(context); // initialize screen dimensions

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 180,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hi, Kristin",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/images/avatar.png',
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "Let’s start learning",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Slider
            SizedBox(
              height: Dimensions.pagePadding,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    // Optionally handle slider index changes
                  });
                },
              ),
              items: imgList
                  .map((item) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(item),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(icons.length, (index) {
            final isSelected = index == _currentIndex;
            return GestureDetector(
              onTap: () => _onTabTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icons[index],
                      color: isSelected ? AppColors.primary : AppColors.hint,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? AppColors.primary : AppColors.hint,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
