import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/blocs/course/course_event.dart';
import 'package:stock_careers/blocs/course/course_state.dart';
import 'package:stock_careers/data/services/course_service.dart';


class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseService _courseService;

  CourseBloc(this._courseService) : super(CourseInitial()) {
    on<LoadCourses>((event, emit) async {
      emit(CourseLoading());
      try {
        final courses = await _courseService.fetchCourses();
        emit(CourseLoaded(courses));
      } catch (e) {
        emit(CourseError(e.toString()));
      }
    });
  }
}
