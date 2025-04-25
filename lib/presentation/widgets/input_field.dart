import 'package:flutter/material.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

class InputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final FocusNode _focusNode = FocusNode();
  String? _errorText;

  @override
  void initState() {
    super.initState();

    // Listener for when the text changes
    widget.controller.addListener(() {
      setState(() {
        // If text is not empty, clear the error text
        _errorText = widget.controller.text.trim().isEmpty
            ? '${widget.label} is required'
            : null;
      });
    });

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // Validate on focus lost (only if text is empty)
        setState(() {
          _errorText = widget.controller.text.trim().isEmpty
              ? '${widget.label} is required'
              : null;
        });
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {}); // Remove listener when disposed
    _focusNode.dispose();
    super.dispose();
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
            widget.label,
            style: TextStyle(
              color: AppColors.hint,
              fontSize: Dimensions.fontMedium,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: AppColors.hint),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.inputField
                  : Colors.white,
              suffixIcon: widget.suffixIcon,
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
          // Display error text below the entire container if the field is empty
          if (_errorText != null && _errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _errorText!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: Dimensions.fontSmall,
                  fontWeight: FontWeight.w200
                ),
              ),
            ),
        ],
      ),
    );
  }
}
