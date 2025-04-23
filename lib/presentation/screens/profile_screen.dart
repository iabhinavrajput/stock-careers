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
        decodedToken = Jwt.parseJwt(token!); // Decode the token
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
            children: [
              const Text(
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
              // Avatar with border and rounded corners
              Image.asset(
                'assets/images/avatar.png',
                height: 100,
                width: 100,
              ),
              // CircleAvatar(
              //   radius: 50,
              //   backgroundImage: AssetImage('assets/images/avatar.png'),
              //   backgroundColor: AppColors.background,
              // ),
              const SizedBox(height: 20),

              // User details section without container
              Column(
                children: [
                  // Username
                  Text(
                    '${decodedToken?['username'] ?? 'N/A'}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Email
                  Text(
                    '${decodedToken?['email'] ?? 'N/A'}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Phone (optional)
                  if (decodedToken?['phone'] != null && decodedToken!['phone'].isNotEmpty) 
                    Text(
                      '${decodedToken!['phone']}',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Additional settings options
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Favourite Courses",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right, color: AppColors.textGrey),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Edit Account",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right, color: AppColors.textGrey),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Settings and Privacy",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right, color: AppColors.textGrey),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Logout",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right, color: AppColors.textGrey),
                          onPressed: () async {
                            // Logout action
                            final authService = AuthService();
                            await authService.logout();

                            // Navigate to login screen and remove all previous routes
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/login', (route) => false);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
