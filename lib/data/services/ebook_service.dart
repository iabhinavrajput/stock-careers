import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/ebook_model.dart';

class EbookService {
  final storage = const FlutterSecureStorage();

  Future<List<Ebook>> fetchEbooks() async {
    final token = await storage.read(key: 'access_token');
    final response = await http.get(
      Uri.parse("https://stockcareers.com/api/ebooks"),
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
