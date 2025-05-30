//new_password
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/presentation/widgets/button/button.dart';

import '../../../blocs/auth/forget_password/forgot_password_bloc.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/dimensions.dart';
import '../../../utils/constants/snackbar_helper.dart';
import '../../widgets/field/password.dart';

class NewPassword extends StatefulWidget {
  final String email;

  const NewPassword({super.key, required this.email});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? newPasswordError;
  String? confirmPasswordError;

  bool get isEnabled {
    return validatePassword(newPasswordController.text) == null &&
        confirmPasswordController.text == newPasswordController.text;
  }

  String? validatePassword(String password) {
    if (password.length < 8) return "At least 8 characters.";
    if (!RegExp(r'[A-Z]').hasMatch(password)) return "At least one uppercase.";
    if (!RegExp(r'[a-z]').hasMatch(password)) return "At least one lowercase.";
    if (!RegExp(r'[0-9]').hasMatch(password)) return "At least one digit.";
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password))
      return "At least one special character.";
    return null;
  }

  bool validateForm() {
    final newPassError = validatePassword(newPasswordController.text);
    final confirmPassError =
        confirmPasswordController.text != newPasswordController.text
            ? "Passwords do not match"
            : null;

    setState(() {
      newPasswordError = newPassError;
      confirmPasswordError = confirmPassError;
    });

    return newPassError == null && confirmPassError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : AppColors.form_scaffold,
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is PasswordResetSuccess) {
            SnackbarHelper.showSnackBar(
              context,
              "Password Reset successfully",
              backgroundColor: Colors.green,
            );
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false); // 👈 go to login
          } else if (state is ForgotPasswordError) {
            SnackbarHelper.showSnackBar(
                context, state.message); // show snackbar here
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Dimensions.screenWidth * 0.3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Enter New Password",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight * 0.03),
              Container(
                  width: Dimensions.screenWidth,
                  height: Dimensions.screenHeight * 0.795,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.form_bg
                        : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        CustomPasswordField(
                          controller: newPasswordController,
                          hintText: "Enter your password",
                          showValidations: false,
                          onValidationChanged: (_) => validateForm(),
                        ),
                        if (newPasswordError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(newPasswordError!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12)),
                            ),
                          ),
                        const SizedBox(height: 15),
                        CustomPasswordField(
                          controller: confirmPasswordController,
                          hintText: "Re-enter your password",
                          showValidations: false,
                          onValidationChanged: (_) => validateForm(),
                        ),
                        if (confirmPasswordError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(confirmPasswordError!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12)),
                            ),
                          ),
                        const SizedBox(height: 30),
                        CustomButton(
                          text: "Continue",
                          onPressed: () {
                            if (validateForm()) {
                              final password =
                                  newPasswordController.text.trim();
                              if (password.length >= 6) {
                                context.read<ForgotPasswordBloc>().add(
                                    ResetPasswordEvent(widget.email, password));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Password must be at least 6 characters")),
                                );
                              }
                            }
                          },
                          backgroundColor: isEnabled
                              ? AppColors.lightPrimary
                              : AppColors.lightPrimary.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}
