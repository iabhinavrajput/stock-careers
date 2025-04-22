import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:stock_careers/utils/constants/api_endpoints.dart';
import '../Models/blog_model.dart';

class BlogService {
  final storage = FlutterSecureStorage();
  
   IOClient _getHttpClient() {
    final ioClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return IOClient(ioClient);
  }

  Future<List<Blog>> fetchBlogs() async {
    final token = await storage.read(key: 'access_token');
    final client = _getHttpClient();
    print('Token: $token');
    final response = await client.get(
      Uri.parse(ApiEndpoints.blog),
      headers: {
        'Authorization': token ?? '',
      },
    );  
    print("Status Code: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Blog data: $data');
      if (data['status']) {
        List blogs = data['data'];
        return blogs.map((e) => Blog.fromJson(e)).toList();
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to fetch blogs');
    }
  }

  Future<Blog> fetchBlogById(String id) async {
    final token = await storage.read(key: 'access_token');
    final client = _getHttpClient();
    final response = await client.get(
      Uri.parse('${ApiEndpoints.blogById}/$id'),
      headers: {
        'Authorization': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status']) {
        return Blog.fromDetailJson(data['data']);
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to fetch blog details');
    }
  }
}
