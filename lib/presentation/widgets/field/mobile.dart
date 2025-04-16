import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

class CustomMobileField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final Function(bool) onValidationChanged; // Add this parameter

  const CustomMobileField({
    super.key,
    required this.controller,
    this.label = 'Mobile Number',
    this.hintText = 'Enter your mobile number',
    required this.onValidationChanged, // Include this in the constructor
  });

  @override
  State<CustomMobileField> createState() => _CustomMobileFieldState();
}

class _CustomMobileFieldState extends State<CustomMobileField> {
  String? errorText;

  void validate(String value) {
    bool isValid = true;

    if (value.isEmpty) {
      errorText = "Mobile number is required";
      isValid = false;
    } else if (value.length < 10) {
      errorText = "Mobile number must be 10 digits";
      isValid = false;
    } else {
      errorText = null;
    }

    setState(() {});
    widget.onValidationChanged(isValid); // Notify the parent widget about validation
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      validate(widget.controller.text);
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {
      validate(widget.controller.text);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.pagePadding * 0.04,
        vertical: Dimensions.pagePadding * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: AppColors.hint,
              fontSize: Dimensions.fontMedium,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: widget.controller,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 10,
            onChanged: validate,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              counterText: "",
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: AppColors.hint),
              filled: true,
              fillColor: isDark ? AppColors.inputField : Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isDark ? AppColors.inputField : AppColors.hint,
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
              // No errorBorder or errorText set — we handle error display manually below
            ),
          ),
          if (errorText != null) ...[
            const SizedBox(height: 5),
            Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
