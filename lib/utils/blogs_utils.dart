import 'dart:convert';
import 'package:http/http.dart' as http;

/// Converts blog name to slug
String slugify(String text) {
  return text
      .toLowerCase()
      // .replaceAll(RegExp(r'[^\w\s-]'), '') // remove special chars
      .replaceAll(RegExp(r'\s+'), '-')     // spaces to dashes
      .replaceAll(RegExp(r'-+'), '-');  
}

/// Fetches blog ID from slug
Future<String?> fetchBlogIdFromSlug(String slug) async {
  final response = await http.get(Uri.parse('https://stockcareers.com/api/blog'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final blogs = data['data'] as List;

    for (var blog in blogs) {
      final blogName = blog['blog_name'] ?? '';
      final blogSlug = slugify(blogName);
      if (blogSlug == slug) {
        return blog['id'];
      }
    }
  }
  return null;
}
