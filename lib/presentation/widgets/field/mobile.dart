import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

class CustomMobileField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;

  const CustomMobileField({
    super.key,
    required this.controller,
    this.label = 'Mobile Number',
    this.hintText = 'Enter your mobile number',
  });

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
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 10,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            decoration: InputDecoration(
              counterText: "", // Hide character counter
              hintText: hintText,
              hintStyle: const TextStyle(color: AppColors.hint),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.inputField
                  : Colors.white,
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
                  color: AppColors.primary,
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
