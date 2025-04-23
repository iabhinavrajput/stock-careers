class CourseDetailModel {
  final String id;
  final String courseName;
  final String courseImage;
  final String author;
  final String lesson;
  final String language;
  final String mode;
  final String duration;
  final String price;
  final String longDescription;

  CourseDetailModel({
    required this.id,
    required this.courseName,
    required this.courseImage,
    required this.author,
    required this.lesson,
    required this.language,
    required this.mode,
    required this.duration,
    required this.price,
    required this.longDescription,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) {
    return CourseDetailModel(
      id: json['id'] ?? '',
      courseName: json['course_name'] ?? '',
      courseImage: json['course_image'] ?? '',
      author: json['author'] ?? '',
      lesson: json['lesson'] ?? '',
      language: json['language'] ?? '',
      mode: json['mode'] ?? '',
      duration: json['duration'] ?? '',
      price: json['price'] ?? '',
      longDescription: json['long_description'] ?? '',
    );
  }
}
