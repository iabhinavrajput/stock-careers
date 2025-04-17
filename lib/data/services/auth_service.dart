//auth_service
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'package:stock_careers/data/models/login_response_model.dart';
import 'package:stock_careers/utils/constants/api_endpoints.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  final String _loginUrl = ApiEndpoints.login;
  final String _registerUrl =
      ApiEndpoints.register; // Add your registration endpoint here
  final String _forgotPasswordUrl = ApiEndpoints.forgotPassword;
  final String _verifyOtpUrl = ApiEndpoints.verifyOtp;
  final String _updatePasswordUrl = ApiEndpoints.updatePassword;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Login logic
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await _makePostRequest(_loginUrl, {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final loginResponse = LoginResponseModel.fromJson(data);

        if (loginResponse.status) {
          await _storage.write(
              key: 'access_token', value: loginResponse.accessToken);
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

  // Register logic
  Future<Map<String, dynamic>> signUp(
    String firstName,
    String lastName,
    String email,
    String mobileNo,
    String password,
  ) async {
    try {
      final response = await _makePostRequest(_registerUrl, {
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'mobile_no': mobileNo,
        'password': password,
      });

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Check if registration was successful
        if (data['status'] == true) {
          await _storage.write(
              key: 'access_token', value: data['access_token']);
        }

        return data;
      } else {
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (e) {
      print("Error during registration: $e");
      throw Exception('Registration failed: $e');
    }
  }

  // Common POST request logic
  Future<http.Response> _makePostRequest(
      String url, Map<String, String> body) async {
    try {
      final httpClient = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;

      final ioClient = IOClient(httpClient);

      final response = await ioClient.post(
        Uri.parse(url),
        body: body,
      );

      return response;
    } catch (e) {
      print("Error making POST request: $e");
      rethrow;
    }
  }

  // Logout logic
  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
  }

  // Check if the user is logged in
  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'access_token');
    return token != null;
  }

  Future<Either<String, void>> sendOtp(String email) async {
    final url = Uri.parse('https://stockcareers.com/api/forgot_password');

    try {
      final response = await http.post(
        url,
        body: ({'email': email}),
      );

      print("✅ OTP Response: ${response.statusCode} => ${response.body}");

      if (response.statusCode == 200) {
        print("Inside sendOtp 200");
        return right(null); // OTP sent successfully
      } else {
        final responseData = jsonDecode(response.body);
        print("Inside sendOtp else case");
        return left(responseData['message'] ?? 'Failed to send OTP');
      }
    } catch (e) {
      print("❌ Unknown Error: $e");
      return left('Something went wrong');
    }
  }

  Future<Either<String, void>> verifyOtp(String email, String otp) async {
    try {
      print('inside verify otp $email $otp');
      final response = await http.post(
        Uri.parse('https://stockcareers.com/api/verify_otp'),
        body: ({"email": email, "otp": otp}),
      );
      print(
          "✅ Verify OTP Response: ${response.statusCode} => ${response.body}");

      if (response.statusCode == 200) {
        return right(null);
      } else {
        return left("Invalid OTP");
      }
    } catch (e) {
      return left("Something went wrong");
    }
  }

  Future<Either<String, void>> resetPassword(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_updatePasswordUrl),
        body: ({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        return right(null);
      } else {
        return left("Password reset failed");
      }
    } catch (e) {
      return left("Something went wrong");
    }
  }
}
