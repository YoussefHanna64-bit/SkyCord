import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/core/theme/app_text_styles.dart';

class CustomRichText extends StatelessWidget {
  final String normalText;
  final String styledText;
  final TextStyle? normalTextStyle;
  final TextStyle? styledTextStyle;
  final VoidCallback? onTap;

  const CustomRichText(
      {super.key,
      required this.normalText,
      required this.styledText,
      this.normalTextStyle,
      this.styledTextStyle,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        recognizer: TapGestureRecognizer()..onTap = onTap,
        text: normalText,
        style: normalTextStyle ?? AppTextStyles.medium14Grey,
        children: [
          TextSpan(
            text: styledText,
            style: styledTextStyle ?? AppTextStyles.bold14Primary,
          ),
        ],
      ),
    );
  }
}
