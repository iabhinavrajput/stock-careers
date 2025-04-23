import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/data/services/blog_service.dart';
import 'blog_detail_event.dart';
import 'blog_detail_state.dart';

class BlogDetailBloc extends Bloc<BlogDetailEvent, BlogDetailState> {
  final BlogService blogService;

  BlogDetailBloc(this.blogService) : super(BlogDetailInitial()) {
    on<FetchBlogDetailEvent>((event, emit) async {
      emit(BlogDetailLoading());
      try {
        final blog = await blogService.fetchBlogById(event.id);
        emit(BlogDetailLoaded(blog));
      } catch (e) {
        emit(BlogDetailError(e.toString()));
      }
    });
  }
}
