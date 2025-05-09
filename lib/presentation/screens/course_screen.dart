import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stock_careers/blocs/course/course_bloc.dart';
import 'package:stock_careers/blocs/course/course_event.dart';
import 'package:stock_careers/blocs/course/course_state.dart';
import 'package:stock_careers/presentation/screens/course_detail_screen.dart';
import 'package:stock_careers/presentation/widgets/bottom_nav_bar.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

import '../../utils/constants/textstyle.dart';
import '../widgets/app_shimmer.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {

  static const IconData currency_rupee_outlined = IconData(0xf05db, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    super.initState();
    context.read<CourseBloc>().add(LoadCourses());
    print("Course Screen Loaded");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state is CourseLoaded) {
          print("Courses loaded: ${state.courses.length}");
        } else if (state is CourseError) {
          print("Error: ${state.message}");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 85,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Courses",
                  style: Theme.of(context).textTheme.headlineMedium,
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
        body: BlocBuilder<CourseBloc, CourseState>(
          builder: (context, state) {
            if (state is CourseLoading) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: AppShimmer(
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 120,
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 16,
                                      width: 180,
                                      color: Colors.grey.shade700,
                                    ),
                                    Container(
                                      height: 14,
                                      width: 120,
                                      color: Colors.grey.shade700,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 14,
                                          width: 60,
                                          color: Colors.grey.shade700,
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          height: 14,
                                          width: 50,
                                          color: Colors.grey.shade700,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 12,
                                      width: 200,
                                      color: Colors.grey.shade700,
                                    ),
                                    Container(
                                      height: 12,
                                      width: 140,
                                      color: Colors.grey.shade700,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is CourseLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.courses.length,
                itemBuilder: (context, index) {
                  final course = state.courses[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CourseDetailScreen(courseId: course.id),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.cardBackground
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // ---------- thumbnail ------------------------------------
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: Dimensions.screenWidth * 0.33,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: AspectRatio(
                                  aspectRatio:
                                      16/10, // ← keeps a horizontal feel
                                  child: Image.network(
                                    course.courseImage,
                                    fit: BoxFit
                                        .cover, // fills the box, no stretch
                                  ),
                                ),
                              ),
                            ),
                            // ---------- text block -----------------------------------
                            const SizedBox(width: 12),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      course.courseName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      course.categoryName,
                                      style:
                                          Theme.of(context).textTheme.titleSmall,
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          course.price.isEmpty
                                              ? 'Free'
                                              : '₹${course.price}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                  color: AppColors.primary),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          course.duration,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is CourseError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: 1, // Set the current index appropriately
          onTabTapped: (index) {
            // Handle tab tap
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/profile');
            } 
            // else if (index == 3) {
            //   Navigator.pushNamed(context, '/ebook');
            // } else if (index == 4) {
            //   Navigator.pushNamed(context, '/profile');
            // }
          },
        ), // Added BottomNavBar here
      ),
    );
  }
}
