import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_careers/data/services/auth_service.dart';
import 'package:stock_careers/presentation/widgets/bottom_nav_bar.dart';
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
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.background
          : Colors.white,
      appBar: AppBar(
        toolbarHeight: 55,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.background
            : Colors.white,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account",
                style: Theme.of(context).textTheme.headlineMedium,
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
              Image.asset(
                'assets/images/avatar.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    '${decodedToken?['username'] ?? 'N/A'}',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  // const SizedBox(height: 5),
                  Text(
                    '${decodedToken?['email'] ?? 'N/A'}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
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
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    _buildRow("Edit Account", () {
                      Navigator.pushNamed(context, '/editProfile');
                    }),
                    _buildRow("About Us", () {}),
                    _buildRow("Disclaimer", () {}),
                    _buildRow("Privacy Policy", () {}),
                    _buildRow("Refund Policy", () {}),
                    _buildRow("Terms & Conditions", () {}),
                    _buildRow("Logout", () async {
                      final authService = AuthService(Dio());
                      await authService.logout();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/login', (route) => false);
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2, // Set the current index for the active tab
        onTabTapped: (index) {
          // Handle tab navigation logic here
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/course');
          }
          // else if (index == 2) {
          //   Navigator.pushNamed(context, '/blog');
          // } else if (index == 3) {
          //   Navigator.pushNamed(context, '/ebook');
          // }
        },
      ),
    );
  }

  Widget _buildRow(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, color: AppColors.textGrey),
          onPressed: onTap,
        ),
      ],
    );
  }

  Widget _buildOptionRow(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, color: AppColors.textGrey),
          onPressed: onTap,
        ),
      ],
    );
  }
}
