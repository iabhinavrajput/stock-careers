import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';
import 'package:stock_careers/utils/constants/textstyle.dart';
import '../widgets/recent_blogs.dart';
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
        toolbarHeight: Dimensions.screenHeight * 0.1,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           "Hi, $username",
          //           style: AppTextStyles.fixed.userName,
          //         ),
          //         Image.asset(
          //           'assets/images/avatar.png',
          //           height: 50,
          //           width: 50,
          //         ),
          //       ],
          //     ),
          //     // const SizedBox(height: 8),
          //      Text(
          //       "Let’s start learning",
          //       style: AppTextStyles.fixed.label,
          //     )
          //   ],
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hi, $username",
                    style: AppTextStyles.fixed.userName,
                  ),
                  Text(
                    "Let’s start learning",
                    style: AppTextStyles.fixed.label,
                  )
                ],
              ),
              Image.asset(
                'assets/images/avatar.png',
                height: 50,
                width: 50,
              ),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Categories",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCategoryItem(
                          context,
                          'assets/images/new/Blog-icon.png',
                          "Blogs",
                          route: '/blog',
                        ),
                        _buildCategoryItem(
                          context,
                          'assets/images/new/Online-classes.png',
                          "Courses",
                          route: '/course',
                        ),
                        _buildCategoryItem(
                            context, 'assets/images/new/E-book.png', "E-Books",
                            route: '/ebook'),
                        _buildCategoryItem(
                          context,
                          'assets/images/new/Webinars-icon.png',
                          "Webinar",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.pagePadding,
                    ),
                    
                    Container(
                        alignment: Alignment.bottomLeft,
                        child: Text('Recent Blogs',
                           
                            style: Theme.of(context).textTheme.displayLarge),
                      ),
                    const SizedBox(height: 12),
                    const RecentBlogs(), // <<< add this widget
                    const SizedBox(height: 20),
                  ]),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTabTapped: (int index) {
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
        },
      ), // 👈 Using your custom BottomNavBar
    );
  }

  Widget _buildCategoryItem(
      BuildContext context, String imagePath, String label,
      {String? route}) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        } else {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Theme.of(context).cardColor,
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                actionsPadding: const EdgeInsets.only(right: 12, bottom: 0),
                title: Row(
                  children: [
                    Icon(Icons.info_rounded,
                        color: AppColors.lightPrimary.withOpacity(0.6),
                        size: 28),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Coming Soon',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Optional illustration
                    // Image.asset(
                    //   isDark
                    //       ? 'assets/images/coming_soon_dark.png'
                    //       : 'assets/images/coming_soon_light.png',
                    //   height: 120,
                    // ),
                    // const SizedBox(height: 16),
                    Text(
                      'This feature is on the way. Stay tuned!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 90,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.lightPrimary.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'OK',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
