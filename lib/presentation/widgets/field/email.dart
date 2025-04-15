// lib/presentation/widgets/custom_email_text_field.dart

import 'package:flutter/material.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

class CustomEmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData icon;
  final Function(bool)? onValidationChanged;

  const CustomEmailTextField({
    super.key,
    required this.controller,
    this.label = 'Email',
    this.hintText = 'Enter your email',
    this.icon = Icons.email,
    this.onValidationChanged,
  });

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.pagePadding * 0.04,
        vertical: Dimensions.pagePadding * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.hint,
              fontSize: Dimensions.fontMedium,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onChanged: (value) {
              if (onValidationChanged != null) {
                onValidationChanged!(isValidEmail(value));
              }
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: AppColors.hint),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.inputField
                  : Colors.white,
              prefixIcon: Icon(icon, color: AppColors.lightPrimary),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.inputField
                      : AppColors.hint,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.lightPrimary,
                  width: 1,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
