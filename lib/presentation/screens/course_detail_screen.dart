import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/blocs/course/course_detail.dart';
import 'package:stock_careers/blocs/course/course_detail_bloc.dart';
import 'package:stock_careers/blocs/course/course_detail_state.dart';
import 'package:stock_careers/data/services/course_service.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_html/flutter_html.dart'; // Import the flutter_html package
import 'package:html/parser.dart'
    as html_parser; // Import the html parser package

class CourseDetailScreen extends StatefulWidget {
  final String courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late CourseDetailBloc _courseDetailBloc;

  @override
  void initState() {
    super.initState();
    _courseDetailBloc = CourseDetailBloc(CourseService());
    _courseDetailBloc.add(LoadCourseDetail(widget.courseId));
  }

  @override
  void dispose() {
    _courseDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final shimmerHeight = screenHeight *
        0.3; // Dynamically set shimmer height based on screen height
    final contentHeight = screenHeight * 0.7; // Content area after shimmer

    return BlocProvider.value(
      value: _courseDetailBloc,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
          builder: (context, state) {
            if (state is CourseDetailLoading) {
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: shimmerHeight, // Dynamically adjust shimmer area
                    child: Container(
                      color: AppColors.grey, // Placeholder color for image area
                    ),
                  ),
                  Positioned(
                    top: shimmerHeight,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[700]!,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Placeholder elements with fixed heights
                              Container(
                                  height: shimmerHeight * 0.1,
                                  width: 200,
                                  color: Colors.grey),
                              const SizedBox(height: 10),
                              Container(
                                  height: shimmerHeight * 0.1,
                                  width: 100,
                                  color: Colors.grey),
                              const SizedBox(height: 30),
                              Container(
                                  height: shimmerHeight * 0.2,
                                  width: 150,
                                  color: Colors.grey),
                              const SizedBox(height: 10),
                              Container(
                                  height: shimmerHeight * 0.2,
                                  width: double.infinity,
                                  color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is CourseDetailLoaded) {
              final course = state.course;

              // Parse the HTML description
              final document = html_parser.parse(course.longDescription);
              final parsedDescription = document.body?.text ?? '';

              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom:
                        screenHeight * 0.7, // Dynamically adjust shimmer area
                    child: course.courseImage.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(course.courseImage),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          )
                        : Container(
                            color:
                                AppColors.grey, // Show grey color if no image
                          ),
                  ),
                  Positioned(
                    top: screenHeight * 0.27,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.cardBackground
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      course.courseName,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    course.price.isEmpty
                                        ? 'Free'
                                        : course.price,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Author: ${course.author}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.grey,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Render the parsed HTML description with custom styles
                              Html(
                                data: course
                                    .longDescription, // Use the original HTML
                                style: {
                                  // Apply styles to HTML tags
                                  'body': Style(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors
                                            .black, // Change body text color
                                  ),
                                  'p': Style(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black, // Paragraph text color
                                    fontSize: FontSize(16),
                                  ),
                                  'h1': Style(
                                    color: AppColors.primary, // Header 1 color
                                    fontSize: FontSize(24),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  'h2': Style(
                                    color: AppColors.primary, // Header 2 color
                                    fontSize: FontSize(20),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  'a': Style(
                                    color: AppColors.primary, // Link color
                                    fontSize: FontSize(16),
                                    textDecoration: TextDecoration.underline,
                                  ),
                                  'img': Style(
                                    width: Width(double
                                        .infinity), // Ensure image stretches across
                                    height: Height(
                                        250), // Set a fixed height for images
                                  ),
                                },
                              ),
                              const SizedBox(height: 40),

                              Container(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Handle button press
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                        ),
                                        child: const Text(
                                          'Enroll Now',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      icon:  Icon(
                                        Icons.share,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        // Handle share action
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.4),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is CourseDetailError) {
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
