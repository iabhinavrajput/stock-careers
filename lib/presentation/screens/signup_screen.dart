import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/blocs/auth/auth_bloc.dart';
import 'package:stock_careers/blocs/auth/auth_event.dart';
import 'package:stock_careers/presentation/widgets/field/email.dart';
import 'package:stock_careers/presentation/widgets/field/mobile.dart';
import 'package:stock_careers/presentation/widgets/field/password.dart';
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
  bool isFormValid = false;
  bool isPasswordValid = false;
  bool isEmailValid = false;
  bool isMobileValid = false;

  void validateForm() {
    setState(() {
      // Check if all fields are filled and valid
      isFormValid = emailController.text.isNotEmpty &&
          firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          mobileNumberController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          isPasswordValid &&
          isEmailValid &&
          isMobileValid;
    });
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(validateForm);
    firstNameController.addListener(validateForm);
    lastNameController.addListener(validateForm);
    mobileNumberController.addListener(validateForm);
    passwordController.addListener(validateForm);
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions.init(context); // initialize screen dimensions

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : AppColors.form_scaffold,
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
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const Text(
                  'Enter your details below & free sign up',
                  style: TextStyle(
                    color: AppColors.hint,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight * 0.02),
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
                  vertical: Dimensions.pagePadding * 0.1,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      InputField(
                        label: 'First Name',
                        controller: firstNameController,
                        hintText: 'first name',
                      ),
                      const SizedBox(height: 10),
                      InputField(
                        label: 'Last Name',
                        controller: lastNameController,
                        hintText: 'last name',
                      ),
                      const SizedBox(height: 10),
                      CustomEmailTextField(
                        controller: emailController,
                        onValidationChanged: (isValid) {
                          isEmailValid = isValid;
                          validateForm();
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomMobileField(
                        controller: mobileNumberController,
                        hintText: '10 Digits Number',
                        onValidationChanged: (isValid) {
                          isMobileValid = isValid;
                          validateForm();
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomPasswordField(
                        controller: passwordController,
                        hintText: 'Password',
                        showValidations: true,
                        onValidationChanged: (isValid) {
                          isPasswordValid = isValid;
                          validateForm();
                        },
                      ),
                      const SizedBox(height: 28),
                     SizedBox(
  width: Dimensions.screenWidth * 0.9,
  height: Dimensions.buttonHeight,
  child: ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.primary.withOpacity(0.5); // Disabled state
          }
          return AppColors.primary; // Enabled state
        },
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    onPressed: isFormValid
        ? () {
            context.read<AuthBloc>().add(
                  SignUpRequested(
                    firstName: firstNameController.text.trim(),
                    lastName: lastNameController.text.trim(),
                    email: emailController.text.trim(),
                    mobileNo: mobileNumberController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                );
          }
        : null,
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
