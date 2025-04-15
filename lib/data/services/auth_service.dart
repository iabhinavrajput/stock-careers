import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'package:stock_careers/data/models/login_response_model.dart';
import 'package:stock_careers/utils/constants/api_endpoints.dart';

class AuthService {
  final String _baseUrl = ApiEndpoints.login;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await _makePostRequest(email, password);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final loginResponse = LoginResponseModel.fromJson(data);

        if (loginResponse.status) {
          await _storage.write(key: 'access_token', value: loginResponse.accessToken);
        }

        return loginResponse;
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      print("Error during login: $e");
      throw Exception('Login failed: $e');
    }
  }

  Future<http.Response> _makePostRequest(String email, String password) async {
    try {
      // Accept invalid SSL certificate (for development/testing only)
      final httpClient = HttpClient()
        ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      final ioClient = IOClient(httpClient);

      final response = await ioClient.post(
        Uri.parse(_baseUrl),
        body: {
          'email': email,
          'password': password,
        },
      );

      return response;
    } catch (e) {
      print("Error making POST request: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'access_token');
    return token != null;
  }
}
