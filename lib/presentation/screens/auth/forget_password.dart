import 'package:flutter/material.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Dimensions.init(context); // ✅ This is the right place
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // backgroundColor: Color(0xffF0F0F2),
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
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 20),
                  Image.asset("assets/images/forget_password.png", height: 130),
                  const SizedBox(height: 30),

                  // Email Input Field

                  const SizedBox(height: 30),

                  // Send OTP Button
                  // Obx(
                  //   () => forgotPasswordController.isLoading.value
                  //       ? const ButtonLoader()
                  //       : GradientButton(
                  //           text: "Send OTP",
                  //           onPressed: isEmailValid.value
                  //               ? () {
                  //                   forgotPasswordController
                  //                       .sendResetOTP(emailController.text);
                  //                 }
                  //               : () {},
                  //           isEnabled: isEmailValid.value),
                  // ),
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
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding:  EdgeInsets.all(Dimensions.pagePadding),
                  child: Column(
                    children: [
                  CustomEmailTextField(
                        controller: emailController,
                        hintText: "Enter your email",
                        icon: Icons.message,
                        onValidationChanged: (isValid) {
                          // isEmailValid.value = isValid;
                          print("Email Valid: $isValid");
                        },
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
