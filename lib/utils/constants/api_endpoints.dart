class ApiEndpoints {

  static const String baseUrl = 'https://stockcareers.com/api';
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String courses = '$baseUrl/courses';
  static const String courseById = '$baseUrl/course_by_id'; 
  static const String blog = '$baseUrl/blog';
  static const String blogById = '$baseUrl/blog_by_id';
  static const String ebook = '$baseUrl/ebooks'; 
  static const String ebookById = '$baseUrl/ebook_by_id';
  static const String fetchUserData = '$baseUrl/user/data';
  static const String updateUserProfile = '$baseUrl/user/update';
  static const String fetchPosts = '$baseUrl/posts';
  static const String createPost = '$baseUrl/posts/create';
  static const String deletePost = '$baseUrl/posts/delete';
  static const String fetchComments = '$baseUrl/comments';
  static const String createComment = '$baseUrl/comments/create';
  static const String deleteComment = '$baseUrl/comments/delete';
  static const String forgotPassword = '$baseUrl/forgot_password';
  static const String verifyOtp = '$baseUrl/verify_otp';
  static const String updatePassword = '$baseUrl/update_password';
}
