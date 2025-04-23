//forget_password
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/presentation/screens/auth/otp_screen.dart';
import 'package:stock_careers/presentation/widgets/button/button.dart';
import 'package:stock_careers/presentation/widgets/field/email.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

import '../../../blocs/auth/forget_password/forgot_password_bloc.dart';
import '../../../data/services/auth_service.dart';
import '../../../utils/constants/snackbar_helper.dart';

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
    return BlocProvider(
        create: (_) => ForgotPasswordBloc(AuthService(Dio())),
        child: Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).scaffoldBackgroundColor
              : AppColors.form_scaffold,
          body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
            listener: (context, state) {
              if (state is OtpSentSuccess) {
                print('🟢 Navigation triggered to PinputExample');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<ForgotPasswordBloc>(),
                      child: PinputExample(email: emailController.text.trim()),
                    ),
                  ),
                );
              } else if (state is ForgotPasswordError) {
                SnackbarHelper.showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              return Center(
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
                          Image.asset("assets/images/forget_password.png",
                              height: 130),
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
                                      final email = emailController.text.trim();
                                      if (email.isNotEmpty) {
                                        print(
                                            "✅ Sending OTP for $email"); // Add this log
                                        context.read<ForgotPasswordBloc>().add(
                                              SendOtpEvent(email),
                                            );
                                      }
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
              );
            },
          ),
        ));
  }
}
