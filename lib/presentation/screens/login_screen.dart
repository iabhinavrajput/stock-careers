import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/blocs/auth/auth_bloc.dart';
import 'package:stock_careers/blocs/auth/auth_event.dart';
import 'package:stock_careers/blocs/auth/auth_state.dart';
import 'package:stock_careers/presentation/screens/auth/forget_password.dart';
import 'package:stock_careers/presentation/widgets/input_field.dart';
import 'package:stock_careers/routes/app_routes.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';
import 'package:stock_careers/utils/helpers/snackbar_helper.dart';

import '../../blocs/auth/forget_password/forgot_password_bloc.dart';
import '../../data/services/auth_service.dart';
import '../widgets/field/email.dart';
import '../widgets/field/password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isEmailValid = false;
  bool isPasswordValid = false;
// or your custom Dio instance
  final authService = AuthService(Dio());

  bool get isFormValid =>
      emailController.text.trim().isNotEmpty &&
      passwordController.text.trim().isNotEmpty &&
      isEmailValid &&
      isPasswordValid;

  void validateForm() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(validateForm);
    passwordController.addListener(validateForm);
  }

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
            SnackbarHelper.showSuccess(context, state.message);
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else if (state is AuthFailure) {
            SnackbarHelper.showError(context, state.error);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).scaffoldBackgroundColor
            : AppColors.form_scaffold,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: EdgeInsets.only(
                top: Dimensions.pagePadding * 5,
                left: Dimensions.pagePadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Log In',
                    style: Theme.of(context).textTheme.headlineLarge,
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
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.form_bg
                      : Colors.white,
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
                        CustomEmailTextField(
                          controller: emailController,
                          onValidationChanged: (isValid) {
                            isEmailValid = isValid;
                            validateForm();
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomPasswordField(
                          controller: passwordController,
                          hintText: 'Password',
                          showValidations: true,
                          onValidationChanged: (isValid) {
                            isPasswordValid = isValid;
                            validateForm();
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (context) =>
                                          ForgotPasswordBloc(authService),
                                      child: ForgotPasswordScreen(),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: AppColors.hint,
                                  fontSize: Dimensions.fontMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: Dimensions.screenWidth * 0.9,
                          height: Dimensions.buttonHeight,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return AppColors.primary.withOpacity(0.5);
                                  }
                                  return AppColors.primary;
                                },
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.white),
                            ),
                            onPressed: isFormValid
                                ? () => _onLoginPressed(context)
                                : null,
                            child: const Text(
                              'Log In',
                              style: TextStyle(fontSize: 16),
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
                                Navigator.pushNamed(context, AppRoutes.signUp);
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
