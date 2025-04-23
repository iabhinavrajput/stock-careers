import 'package:stock_careers/data/Models/blog_model.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;

  BlogLoaded(this.blogs);
}

class BlogError extends BlogState {
  final String message;

  BlogError(this.message);
}
