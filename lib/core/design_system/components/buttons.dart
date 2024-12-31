import '../colors.dart';
import '../typography.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isActive;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: isActive ? AppColors.primary : AppColors.grey,
        textStyle: AppTypography.button,
      ),
      child: Text(text),
    );
  }
}