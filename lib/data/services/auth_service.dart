import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:stock_careers/data/models/login_response_model.dart';
import 'package:stock_careers/utils/constants/api_endpoints.dart';

class AuthService {
  final String _baseUrl = ApiEndpoints.login;

  Future<LoginResponseModel> login(String email, String password) async {
    try {
      // Set up custom HttpClient to bypass SSL
      final client = http.Client();
      final httpRequest = await _makePostRequest(client, email, password);

      // If the server returns a successful response
      if (httpRequest.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(httpRequest.body);
        return LoginResponseModel.fromJson(data);
      } else {
        // Handle failure (invalid credentials, etc.)
        throw Exception('Failed to login: ${httpRequest.body}');
      }
    } catch (e) {
      // Catch any error (network issues, etc.)
      print("Error during login: $e");
      throw Exception('Login failed: $e');
    }
  }

  // Function to make POST request
  Future<http.Response> _makePostRequest(http.Client client, String email, String password) async {
    try {
      // Create a custom HttpClient to bypass certificate verification
      final httpClient = HttpClient();
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true; // Ignore SSL errors
      final ioClient = IOClient(httpClient);

      final response = await ioClient.post(
        Uri.parse(_baseUrl),
        // headers: {
        //   "Content-Type": "application/json", // Set content type
        // },
        body: ({
          'email': email,
          'password': password,
        }),
      );
      return response;
    } catch (e) {
      print("Error making POST request: $e");
      rethrow;
    }
  }
}
