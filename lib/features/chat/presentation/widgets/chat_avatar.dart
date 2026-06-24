import 'package:flutter/material.dart';
import 'package:sky_cord/core/theme/app_colors.dart';
import 'package:sky_cord/core/theme/app_text_styles.dart';

class ChatAvatar extends StatelessWidget {
  final String username;
  final String? pfp;
  final double radius;

  const ChatAvatar({
    super.key,
    required this.username,
    this.pfp,
    this.radius = 18,
  });

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary.withAlpha(51),
      backgroundImage: pfp != null ? NetworkImage(pfp!) : null,
      child: pfp == null
          ? Text(
              username[0].toUpperCase(),
              style: AppTextStyles.bold16White.copyWith(color: onSurface),
            )
          : null,
    );
  }
}
