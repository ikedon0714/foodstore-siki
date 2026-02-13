// New file: lib/core/widgets/app_text_field.dart

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.enabled = true,
    this.textInputAction,
    this.keyboardType,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final String labelText;
  final String? hintText;

  final IconData? prefixIcon;
  final Widget? suffixIcon;

  final bool obscureText;
  final String? Function(String?)? validator;
  final bool enabled;

  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      validator: validator,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      decoration: AppInputStyles.defaultDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
