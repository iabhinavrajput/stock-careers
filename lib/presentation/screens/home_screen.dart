import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';
import 'package:stock_careers/utils/constants/textstyle.dart';
import 'course_screen.dart'; // Import your CourseScreen here
import 'package:carousel_slider/carousel_slider.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/Presentation/Widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "Loading...";

  List<String> imgList = [
    'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png',
    'https://foundr.com/wp-content/uploads/2023/04/How-to-create-an-online-course.jpg.webp',
    'https://blogassets.leverageedu.com/blog/wp-content/uploads/2020/05/23151218/BA-Courses.png',
  ];

  @override
  void initState() {
    super.initState();
    _getUsernameFromToken();
  }

  Future<void> _getUsernameFromToken() async {
    final storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');
    if (token != null) {
      final decodedToken = Jwt.parseJwt(token);
      setState(() {
        username = decodedToken['username'] ?? 'Guest';
      });
    }
  }

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
                  Text(
                    "Hi, $username",
                    style: const TextStyle(
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Categories",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryItem(
                    context,
                    'assets/images/Market_Analysis.png',
                    "Market\nAnalysis",
                  ),
                  _buildCategoryItem(
                    context,
                    'assets/images/Informative_Blogs.png',
                    "Informative\nBlogs",
                    route: '/blog',
                  ),
                  _buildCategoryItem(
                    context,
                    'assets/images/Webinar_Sessions.png',
                    "Webinar\nSessions",
                  ),
                  _buildCategoryItem(
                    context,
                    'assets/images/Online_Classes.png',
                    "Online\nClasses",
                    route: '/course',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0, onTabTapped: (int index) { 
        // Handle tab tap
         if (index == 1) {
          Navigator.pushNamed(context, '/course');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/blog');
        } else if (index == 3) {
          Navigator.pushNamed(context, '/ebook');
        } else if (index == 4) {
          Navigator.pushNamed(context, '/profile');
        }
       },), // 👈 Using your custom BottomNavBar
    );
  }

  Widget _buildCategoryItem(BuildContext context, String imagePath, String label,
      {String? route}) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Coming Soon'),
              content: const Text('This feature is coming soon.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Column(
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
