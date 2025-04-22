class Blog {
  final String id;
  final String seoTitle;
  final String keywords;
  final String seoDesc;
  final String blogName;
  final String blogImage;
  final String blogDate;
  final String blogAuthor;
  final String blogDesc;
  final String longDesc;

  Blog({
    required this.id,
    required this.seoTitle,
    required this.keywords,
    required this.seoDesc,
    required this.blogName,
    required this.blogImage,
    required this.blogDate,
    required this.blogAuthor,
    required this.blogDesc,
    required this.longDesc,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      seoTitle: json['seo_title'],
      keywords: json['keywords'],
      seoDesc: json['seo_desc'],
      blogName: json['blog_name'],
      blogImage: json['blog_image'],
      blogDate: json['blog_date'],
      blogAuthor: json['blog_author'],
      blogDesc: json['blog_desc'],
      longDesc: json['long_desc'],
    );
  }
  factory Blog.fromDetailJson(Map<String, dynamic> json) {
  return Blog(
    id: json['id'],
    seoTitle: json['seo_title'],
    keywords: json['keywords'],
    seoDesc: json['seo_desc'],
    blogName: json['blog_name'],
    blogImage: "https://stockcareers.com/uploads/blogs/${json['blog_image']}",
    blogDate: json['blog_date'],
    blogAuthor: json['blog_author'],
    blogDesc: json['blog_desc'],
    longDesc: json['long_desc'],
  );
}

}
