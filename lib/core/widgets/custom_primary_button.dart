import 'package:flutter/material.dart';
import 'package:sky_cord/core/theme/app_colors.dart';
import 'package:sky_cord/core/theme/app_text_styles.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String buttonText;
  final Color? fillColor;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const CustomPrimaryButton({
    super.key,
    required this.buttonText,
    this.fillColor,
    this.width = double.infinity,
    this.height,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: fillColor ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(buttonText, style: AppTextStyles.bold16White),
      ),
    );
  }
}
