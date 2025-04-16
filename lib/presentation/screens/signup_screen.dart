import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/blocs/auth/auth_bloc.dart';
import 'package:stock_careers/blocs/auth/auth_event.dart';
import 'package:stock_careers/presentation/widgets/input_field.dart';
import 'package:stock_careers/routes/app_routes.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Dimensions.init(context); // initialize screen dimensions

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.pagePadding * 3,
              left: Dimensions.pagePadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(height: 1),
                const Text(
                  'Enter your details below & free sign up',
                  style: TextStyle(
                    color: AppColors.hint,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight*0.02),
              ],
            ),
          ),

          // Form Section with Rounded Background
          Expanded(
            child: Container(
              height: Dimensions.screenHeight * 0.8,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.pagePadding,
                  vertical: Dimensions.pagePadding*0.1,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      InputField(
                        label: 'Your Email',
                        controller: emailController,
                        hintText: 'example@mail.com',
                      ),
                      InputField(
                        label: 'First Name',
                        controller: firstNameController,
                        hintText: 'first name',
                      ),
                      InputField(
                        label: 'Last Name',
                        controller: lastNameController,
                        hintText: 'last name',
                      ),
                      InputField(
                        label: 'Mobile Number',
                        controller: mobileNumberController,
                        hintText: '10 digits number',
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        label: 'Password',
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: !isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.hint,
                          ),
                          onPressed: () {
                            setState(
                                () => isPasswordVisible = !isPasswordVisible);
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: Dimensions.screenWidth * 0.9,
                        height: Dimensions.buttonHeight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  SignUpRequested(
                                    firstName: firstNameController.text.trim(),
                                    lastName: lastNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    mobileNo:
                                        mobileNumberController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                          },
                          child: const Text(
                            'Create account',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.login);
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
