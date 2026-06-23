import 'package:flutter/material.dart';
import 'package:sky_cord/core/theme/app_colors.dart';
import 'package:sky_cord/core/theme/app_text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.obscureText = false,
    required this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isSecure;

  @override
  void initState() {
    super.initState();
    isSecure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onSurface = colorScheme.onSurface;
    final dividerColor = theme.dividerColor;

    return TextFormField(
      style: AppTextStyles.regular14Black.copyWith(color: onSurface),
      cursorColor: AppColors.primary,
      controller: widget.controller,
      obscureText: widget.obscureText ? isSecure : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.regular14Black
            .copyWith(color: onSurface.withAlpha(100)),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: theme.hintColor, size: 22)
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  isSecure ? Icons.visibility_off : Icons.visibility,
                  color: isSecure ? dividerColor : AppColors.primary,
                  size: 22,
                ),
                onPressed: () {
                  setState(() {
                    isSecure = !isSecure;
                  });
                },
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}
