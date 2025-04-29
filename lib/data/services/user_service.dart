import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../presentation/screens/home_screen.dart';

class UserService {
  final storage = FlutterSecureStorage();

  // HTTP request to update user profile
  Future<bool> updateUserProfile({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String mobileNo,
  }) async {
    final token = await storage.read(key: 'access_token');

    if (token == null) {
      throw Exception("Token not found");
    }

    final url =
        Uri.parse('https://stockcareers.com/api/update_user_by_id/$userId');

    final body = jsonEncode({
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'mobile_no': mobileNo,
    });

    try {
      print(
          "User data in user service: $firstName,$lastName,$email,$mobileNo , $userId,$token");

      final response = await http.put(
        url, // Use POST instead of PATCH, since 405 was returned earlier
        headers: {
          'Authorization': token,
        },
        body: body,
      );

      print("Status code: ${response.statusCode}");
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['access_token'] != null) {
          await storage.write(
            key: 'access_token',
            value: responseData['access_token'],
          );
          print("New token updated in secure storage");
        }

        // 🟢 Only navigate AFTER token is stored

        ;
        return true;
      } else {
        print('Update failed: ${response.statusCode} ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }
}
