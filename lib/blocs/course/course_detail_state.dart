import 'package:stock_careers/data/models/course_detail_model.dart';

abstract class CourseDetailState {}

class CourseDetailInitial extends CourseDetailState {}

class CourseDetailLoading extends CourseDetailState {}

class CourseDetailLoaded extends CourseDetailState {
  final CourseDetailModel course;
  CourseDetailLoaded(this.course);
}

class CourseDetailError extends CourseDetailState {
  final String message;
  CourseDetailError(this.message);
}
