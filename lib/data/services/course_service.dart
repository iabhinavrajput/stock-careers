import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stock_careers/utils/constants/api_endpoints.dart';
import '../models/course_model.dart';

class CourseService {
  final _storage = const FlutterSecureStorage();

  // Custom HttpClient to ignore bad SSL cert (DEV ONLY)
  IOClient _getHttpClient() {
    final ioClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return IOClient(ioClient);
  }

  Future<List<Course>> fetchCourses() async {
    final token = await _storage.read(key: 'access_token');
    final client = _getHttpClient();

    final response = await client.get(
      Uri.parse(ApiEndpoints.courses),
      headers: {
        'Authorization': '$token',
      },
    );

    print("Response: ${response.body}");
    print("Status Code: ${response.statusCode}");

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List data = decoded['data'];

      if (data.isEmpty) {
        print("No courses available");
        return [];
      }

      return data.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch courses');
    }
  }
}
