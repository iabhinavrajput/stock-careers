import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stock_careers/blocs/course/course_bloc.dart';
import 'package:stock_careers/blocs/course/course_event.dart';
import 'package:stock_careers/blocs/course/course_state.dart';
import 'package:stock_careers/presentation/screens/course_detail_screen.dart';
import 'package:stock_careers/utils/constants/colors.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
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
          backgroundColor: AppColors.background,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Courses",
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
          ),
        ),
        backgroundColor: AppColors.background,
        body: BlocBuilder<CourseBloc, CourseState>(
          builder: (context, state) {
            if (state is CourseLoading) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade800,
                      highlightColor: Colors.grey.shade700,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            // Image placeholder
                            Container(
                              width: 100,
                              height: 120,
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            // Text placeholders
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
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.cardBackgroundLight,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.network(course.courseImage,
                                  width: 80, height: 100, fit: BoxFit.fitWidth),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(course.courseName,
                                        style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 6),
                                    Text(course.categoryName,
                                        style: const TextStyle(
                                            color: AppColors.hint,
                                            fontSize: 14)),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Text(
                                            "Price: ${course.price.isEmpty ? 'Free' : course.price}",
                                            style: const TextStyle(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 10),
                                        Text(course.duration,
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
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
      ),
    );
  }
}
