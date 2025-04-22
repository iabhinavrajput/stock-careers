import 'package:stock_careers/data/Models/blog_model.dart';

abstract class BlogDetailState {}

class BlogDetailInitial extends BlogDetailState {}

class BlogDetailLoading extends BlogDetailState {}

class BlogDetailLoaded extends BlogDetailState {
  final Blog blog;
  BlogDetailLoaded(this.blog);
}

class BlogDetailError extends BlogDetailState {
  final String message;
  BlogDetailError(this.message);
}
