import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/blocs/auth/auth_bloc.dart';
import 'package:stock_careers/blocs/auth/auth_event.dart';
import 'package:stock_careers/blocs/auth/auth_state.dart';
import 'package:stock_careers/presentation/widgets/input_field.dart';
import 'package:stock_careers/routes/app_routes.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      print('Logging in with email: $email and password: $password');
      context.read<AuthBloc>().add(LoginRequested(email, password));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Dimensions.init(context); // initialize screen dimensions

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else {
          Navigator.of(context).pop(); // close loading dialog
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: EdgeInsets.only(
                top: Dimensions.pagePadding * 5,
                left: Dimensions.pagePadding,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Log In',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
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
                    vertical: Dimensions.pagePadding,
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
                              setState(() =>
                                  isPasswordVisible = !isPasswordVisible);
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: AppColors.hint,
                                fontSize: Dimensions.fontMedium,
                              ),
                            ),
                          ],
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
                            onPressed: () => _onLoginPressed(context),
                            child: const Text(
                              'Log In',
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
                              'Don’t have an account? ',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.signUp);
                              },
                              child: const Text(
                                'Sign up',
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
      ),
    );
  }
}
