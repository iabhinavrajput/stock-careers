abstract class BlogDetailEvent {}

class FetchBlogDetailEvent extends BlogDetailEvent {
  final String id;
  FetchBlogDetailEvent(this.id);
}
