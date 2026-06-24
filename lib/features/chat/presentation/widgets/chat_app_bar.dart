import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/core/services/user_status_service.dart';
import 'package:sky_cord/core/theme/app_colors.dart';
import 'package:sky_cord/core/theme/app_text_styles.dart';
import 'package:sky_cord/features/chat/presentation/widgets/chat_avatar.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String otherUserId;
  final String? pfp;

  const ChatAppBar(
      {super.key, required this.username, required this.otherUserId, this.pfp});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return AppBar(
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.greyColor),
      title: Row(
        children: [
          ChatAvatar(
            username: username,
            pfp: pfp,
            radius: 18,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: AppTextStyles.bold16White.copyWith(color: onSurface),
              ),
              StreamBuilder<DatabaseEvent>(
                stream: UserStatusService.instance.getUserStatus(otherUserId),
                builder: (context, snapshot) {
                  bool isOnline = false;
                  bool isTyping = false;

                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    final data = Map<String, dynamic>.from(
                        snapshot.data!.snapshot.value as Map);
                    isOnline = data["online"] ?? false;
                    isTyping = data["typing"] ?? false;
                  }

                  if (isTyping) {
                    return const Text(
                      "Typing...",
                      style: AppTextStyles.medium12Green,
                    );
                  } else if (isOnline) {
                    return const Text(
                      "Online",
                      style: AppTextStyles.medium12Primary,
                    );
                  } else {
                    return Text(
                      "Offline",
                      style: AppTextStyles.medium12Grey,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
