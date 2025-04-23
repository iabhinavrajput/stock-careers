//otp_screen
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';
import 'package:stock_careers/blocs/auth/forget_password/forgot_password_bloc.dart';
import 'package:stock_careers/presentation/screens/auth/new_password.dart';
import 'package:stock_careers/presentation/widgets/button/button.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

class PinputExample extends StatefulWidget {
  final String email; // <-- Add this

  const PinputExample({Key? key, required this.email}) : super(key: key);

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  late final SmsRetriever smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  bool isButtonEnabled = false; // Track the button state

  @override
  void initState() {
    super.initState();
    // On web, disable the browser's context menu since this example uses a custom
    // Flutter-rendered context menu.
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();

    pinController.addListener(_checkPin); // Add listener to detect changes

    /// In case you need an SMS autofill feature
    // smsRetriever = SmsRetrieverImpl();
  }

  @override
  void dispose() {
    if (kIsWeb) {
      BrowserContextMenu.enableContextMenu();
    }
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  // Function to check if all digits are entered
  void _checkPin() {
    setState(() {
      isButtonEnabled =
          pinController.text.length == 4; // Assuming the PIN length is 4
    });
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.lightPrimary;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = AppColors.grey;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is OtpVerifiedSuccess) {
            // Navigate to NewPassword screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NewPassword(email: widget.email),
              ),
            );
          } else if (state is ForgotPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          // ✅ Wrap with Scaffold
          body: Center(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.pagePadding,
                    vertical: Dimensions.pagePadding * 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const BackButton(),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "OTP Verification",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        ),
                        // This keeps the center alignment even with BackButton
                        const SizedBox(width: 48), // Equal width as BackButton
                      ],
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        // smsRetriever: smsRetriever,
                        controller: pinController,
                        focusNode: focusNode,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                    ),
                    CustomButton(
                      text: "Validate",
                      onPressed: isButtonEnabled
                          ? () {
                              print("Email in button: ${widget.email}");
                              final otp = pinController.text;
                              // Trigger VerifyOtpEvent with email and entered OTP
                              context.read<ForgotPasswordBloc>().add(
                                    VerifyOtpEvent(widget.email, otp),
                                  );
                            }
                          : null,
                      // Disable the button by passing null if not enabled
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
