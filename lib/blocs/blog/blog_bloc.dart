import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/data/services/blog_service.dart';
import 'blog_event.dart';
import 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogService blogService;

  BlogBloc(this.blogService) : super(BlogInitial()) {
    // Register event handler for FetchBlogsEvent
    on<FetchBlogsEvent>((event, emit) async {
      emit(BlogLoading());
      try {
        final blogs = await blogService.fetchBlogs();
        emit(BlogLoaded(blogs));
      } catch (e) {
        emit(BlogError(e.toString()));
      }
    });
  }
}
