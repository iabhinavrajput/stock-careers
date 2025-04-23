import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/blocs/course/course_detail.dart';
import 'package:stock_careers/data/services/course_service.dart';
import 'course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  final CourseService service;

  CourseDetailBloc(this.service) : super(CourseDetailInitial()) {
    on<LoadCourseDetail>((event, emit) async {
      emit(CourseDetailLoading());
      try {
        final course = await service.fetchCourseDetail(event.courseId);
        emit(CourseDetailLoaded(course));
      } catch (e) {
        emit(CourseDetailError(e.toString()));
      }
    });
  }
}
