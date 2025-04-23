class Course {
  final String id;
  final String courseName;
  final String courseImage;
  final String author;
  final String category;
  final String categoryName;
  final String mode;
  final String language;
  final String languageName;
  final String lesson;
  final String? introVideo;
  final String duration;
  final String status;
  final String seoDesc;
  final String price;
  final String basePrice;
  final String longDescription;
  final String recommended;
  final String seoKeywords;
  final String seoTitle;

  Course({
    required this.id,
    required this.courseName,
    required this.courseImage,
    required this.author,
    required this.category,
    required this.categoryName,
    required this.mode,
    required this.language,
    required this.languageName,
    required this.lesson,
    this.introVideo,
    required this.duration,
    required this.status,
    required this.seoDesc,
    required this.price,
    required this.basePrice,
    required this.longDescription,
    required this.recommended,
    required this.seoKeywords,
    required this.seoTitle,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '',
      courseName: json['course_name'] ?? '',
      courseImage: json['course_image'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? '',
      categoryName: json['category_name'] ?? '',
      mode: json['mode'] ?? '',
      language: json['language'] ?? '',
      languageName: json['language_name'] ?? '',
      lesson: json['lesson'] ?? '',
      introVideo: json['intro_video'],
      duration: json['duration'] ?? '',
      status: json['status'] ?? '',
      seoDesc: json['seo_desc'] ?? '',
      price: json['price'] ?? '',
      basePrice: json['base_price'] ?? '',
      longDescription: json['long_description'] ?? '',
      recommended: json['recommended'] ?? '',
      seoKeywords: json['seo_keywords'] ?? '',
      seoTitle: json['seo_title'] ?? '',
    );
  }
}
