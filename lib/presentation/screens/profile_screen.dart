import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stock_careers/data/services/auth_service.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:jwt_decode/jwt_decode.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? token;
  Map<String, dynamic>? decodedToken;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    final storage = const FlutterSecureStorage();
    final storedToken = await storage.read(key: 'access_token');
    setState(() {
      token = storedToken;
      if (token != null) {
        decodedToken = Jwt.parseJwt(token!);
      }
    });
    print("Decoded Token in profile : $decodedToken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 85,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Account",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Avatar
              Image.asset(
                'assets/images/avatar.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 20),

              // User Info
              Column(
                children: [
                  Text(
                    '${decodedToken?['username'] ?? 'N/A'}',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${decodedToken?['email'] ?? 'N/A'}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (decodedToken?['phone'] != null &&
                      decodedToken!['phone'].isNotEmpty)
                    Text(
                      '${decodedToken!['phone']}',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Options
              Column(
                children: [
                  _buildOptionRow("Favourite Courses", () {}),
                  const SizedBox(height: 8),
                  _buildOptionRow("Edit Account", () {}),
                  const SizedBox(height: 8),
                  _buildOptionRow("Settings and Privacy", () {}),
                  const SizedBox(height: 8),
                  _buildOptionRow("Logout", () async {
                    final authService = AuthService(Dio());
                    await authService.logout();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login', (route) => false);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionRow(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, color: AppColors.textGrey),
          onPressed: onTap,
        ),
      ],
    );
  }
}
