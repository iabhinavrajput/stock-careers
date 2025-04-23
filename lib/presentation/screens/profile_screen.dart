import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stock_careers/data/services/auth_service.dart';
import 'package:stock_careers/utils/constants/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      body: Column(
        children: [
          Center(
            child: Image.asset(
              'assets/images/avatar.png',
              height: 100,
              width: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
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
                    // const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.chevron_right,
                          color: AppColors.textGrey),
                      onPressed: () {
                        // Edit profile action
                      },
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
                    // const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.chevron_right,
                          color: AppColors.textGrey),
                      onPressed: () {
                        // Edit profile action
                      },
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
                    // const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.chevron_right,
                          color: AppColors.textGrey),
                      onPressed: () {
                        // Edit profile action
                      },
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
                      icon: const Icon(Icons.chevron_right,
                          color: AppColors.textGrey),
                      onPressed: () async {
                        // Logout action
                        final authService = AuthService(Dio());
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
    );
  }
}
