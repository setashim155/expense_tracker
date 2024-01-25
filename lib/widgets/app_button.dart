import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final String labelText;
  final bool isLoading;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.labelText,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor,
        foregroundColor: AppColors.textColor1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size(double.infinity, 62),
        fixedSize: const Size(double.infinity, 62),
      ),
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.textColor1))
          : Text(
              labelText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
