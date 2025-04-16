import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/blocs/course/course_detail.dart';
import 'package:stock_careers/blocs/course/course_detail_bloc.dart';
import 'package:stock_careers/blocs/course/course_detail_state.dart';
import 'package:stock_careers/data/services/course_service.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CourseDetailBloc(CourseService())..add(LoadCourseDetail(courseId)),
      child: Scaffold(
        appBar: AppBar(title: const Text("Course Details")),
        body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
          builder: (context, state) {
            if (state is CourseDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CourseDetailLoaded) {
              final course = state.course;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(course.courseImage),
                    const SizedBox(height: 16),
                    Text(course.courseName,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("Author: ${course.author}"),
                    Text("Lessons: ${course.lesson}"),
                    Text("Language: ${course.language}"),
                    Text("Mode: ${course.mode}"),
                    Text("Duration: ${course.duration}"),
                    Text("Price: ${course.price.isEmpty ? 'Free' : course.price}"),
                    const SizedBox(height: 16),
                    const Text("Description:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      course.longDescription.replaceAll(RegExp(r'<[^>]*>|&nbsp;|&rsquo;'), '').trim(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
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
