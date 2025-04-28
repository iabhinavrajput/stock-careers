import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_careers/data/services/auth_service.dart';
import 'package:stock_careers/presentation/widgets/bottom_nav_bar.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:stock_careers/utils/content/disclaimer.dart';
import 'package:stock_careers/utils/content/privacy_policy.dart';
import 'package:stock_careers/utils/content/refund_policy.dart';
import 'package:stock_careers/utils/content/terms_and_conditions.dart';
import '../../data/models/user_model.dart';
import '../../utils/content/about_us.dart';
import '../StaticContent/static_content_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? token;
  UserModel? user; // <-- model instead of raw map

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
      final decodedToken = Jwt.parseJwt(token!);
      // Map the decoded token to UserModel
      user = UserModel.fromMap(decodedToken); // <-- Use UserModel's fromMap method
    }
  });
  print("Decoded Token User model: $user");
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
                    user?.username ?? 'N/A',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  // const SizedBox(height: 5),
                  Text(
                    user?.email ?? 'N/A',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  if (user?.phone != null && user!.phone!.isNotEmpty)
                    Text(
                      user!.phone!,
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
                    _buildRow("About Us", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StaticContentScreen(
                            title: "About Us",
                            content: aboutUsContent,
                          ),
                        ),
                      );
                    }),
                    _buildRow("Disclaimer", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StaticContentScreen(
                            title: "Disclaimer",
                            content: disclaimerContent,
                          ),
                        ),
                      );
                    }),
                    _buildRow("Privacy Policy", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StaticContentScreen(
                            title: "Privacy Policy",
                            content: privacyPolicyContent,
                          ),
                        ),
                      );
                    }),
                    _buildRow("Refund Policy", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StaticContentScreen(
                            title: "Refund Policy",
                            content: refundPolicyContent,
                          ),
                        ),
                      );
                    }),
                    _buildRow("Terms & Conditions", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StaticContentScreen(
                            title: "Terms & Conditions",
                            content: termsAndConditionsContent,
                          ),
                        ),
                      );
                    }),
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
