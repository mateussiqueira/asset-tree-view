import '../colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String labelText;
  final ValueChanged<String> onChanged;

  const AppTextField({
    super.key,
    required this.labelText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        labelStyle: const TextStyle(color: AppColors.grey),
      ),
      onChanged: onChanged,
    );
  }
}