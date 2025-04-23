import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stock_careers/utils/constants/api_endpoints.dart';
import '../models/ebook_model.dart';

class EbookService {
  final storage = const FlutterSecureStorage();

  Future<List<Ebook>> fetchEbooks() async {
    final token = await storage.read(key: 'access_token');
    print("token inside the ebook service: $token");
    print("Ebook URL: ${ApiEndpoints.ebook}");
    print("Ebook URL: ${ApiEndpoints.ebook}");
    final response = await http.get(
      Uri.parse(ApiEndpoints.ebook),
      headers: {'Authorization': token ?? ''},
    );

    final data = json.decode(response.body);
    if (data['status']) {
      return (data['data'] as List).map((e) => Ebook.fromJson(e)).toList();
    } else {
      throw Exception(data['message']);
    }
  }
}
