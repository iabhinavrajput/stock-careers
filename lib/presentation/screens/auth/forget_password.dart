import 'package:flutter/material.dart';
import 'package:stock_careers/presentation/screens/auth/otp_screen.dart';
import 'package:stock_careers/presentation/widgets/button/button.dart';
import 'package:stock_careers/presentation/widgets/field/email.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isEmailValid = false; // 👈 Add this

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Dimensions.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : AppColors.form_scaffold,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: Dimensions.screenHeight * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    "RESET PASSWORD",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  Image.asset("assets/images/forget_password.png", height: 130),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            Container(
              width: Dimensions.screenWidth,
              height: Dimensions.screenHeight * 0.6,
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
                padding: EdgeInsets.all(Dimensions.pagePadding),
                child: Column(
                  children: [
                    CustomEmailTextField(
                      controller: emailController,
                      hintText: "Enter your email",
                      icon: Icons.email,
                      onValidationChanged: (isValid) {
                        setState(() {
                          isEmailValid = isValid;
                        });
                      },
                    ),
                    SizedBox(height: Dimensions.pagePadding),
                    CustomButton(
                      text: "Send OTP",
                      onPressed: isEmailValid
                          ? () {
                              // Handle OTP logic
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const PinputExample()),
                              );
                              print("Sending OTP to: ${emailController.text}");
                            }
                          : () {},
                      backgroundColor: isEmailValid
                          ? AppColors.lightPrimary
                          : AppColors.lightPrimary.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
