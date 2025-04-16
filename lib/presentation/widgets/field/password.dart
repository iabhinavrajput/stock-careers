import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool showValidations;
  final Function(bool) onValidationChanged;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    this.showValidations = false,
    required this.onValidationChanged,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<String> validationMessage = ValueNotifier('');

  bool _isFocused = false;

  bool get _showFloatingLabel =>
      _isFocused || widget.controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    isPasswordVisible.dispose();
    validationMessage.dispose();
    super.dispose();
  }

  void validatePassword(String password) {
    String message = '';
    bool isValid = true;

    if (password.isEmpty) {
      message = "Password cannot be empty";
      isValid = false;
    } else if (password.length < 8) {
      message = "Password must be at least 8 characters";
      isValid = false;
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      message = "Password must contain at least one uppercase letter";
      isValid = false;
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      message = "Password must contain at least one digit";
      isValid = false;
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      message = "Password must contain at least one special character";
      isValid = false;
    }

    validationMessage.value = message;
    widget.onValidationChanged(isValid);
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: _showFloatingLabel
                    ? const LinearGradient(
                        colors: [
                          AppColors.lightPrimary,
                          AppColors.lightPrimary,
                        ],
                      )
                    : null,
                color: Colors.white,
                borderRadius: borderRadius,
              ),
              padding: _showFloatingLabel
                  ? const EdgeInsets.all(0.7)
                  : EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.form_bg
                        : Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      width: 0.5,
                      color: _showFloatingLabel
                          ? AppColors.lightPrimary
                          :  AppColors.grey,
                    )),
                child: ValueListenableBuilder<bool>(
                  valueListenable: isPasswordVisible,
                  builder: (context, isVisible, _) {
                    return TextField(
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                      ),
                      controller: widget.controller,
                      focusNode: _focusNode,
                      obscureText: !isVisible,
                      obscuringCharacter: '*',
                      onChanged: validatePassword,
                      cursorColor: AppColors.form_bg,
                      
                      decoration: InputDecoration(
                        hintText: _showFloatingLabel ? '' : widget.hintText,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        suffixIcon: _showFloatingLabel
                            ? ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                  colors: [
                                    AppColors.lightPrimary,
                                    AppColors.lightPrimary,
                                  ],
                                ).createShader(Rect.fromLTWH(
                                        0, 0, bounds.width, bounds.height)),
                                child: IconButton(
                                  icon: Icon(
                                    isVisible ? Icons.lock_open : Icons.lock,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    isPasswordVisible.value = !isVisible;
                                  },
                                ),
                              )
                            : IconButton(
                                icon: Icon(
                                  isVisible ? Icons.lock_open : Icons.lock,
                                  color: AppColors.grey,
                                ),
                                onPressed: () {
                                  isPasswordVisible.value = !isVisible;
                                },
                              ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (_showFloatingLabel)
              Positioned(
                left: 15,
                top: -7,
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.form_bg
                      : Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        AppColors.lightPrimary,
                        AppColors.lightPrimary,
                      ],
                    ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                    child: Text(
                      widget.hintText,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (widget.showValidations)
          ValueListenableBuilder<String>(
            valueListenable: validationMessage,
            builder: (context, message, _) {
              return message.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
      ],
    );
  }
}
