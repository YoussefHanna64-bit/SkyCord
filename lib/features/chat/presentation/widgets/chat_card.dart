import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/core/services/user_status_service.dart';
import 'package:sky_cord/core/theme/app_colors.dart';
import 'package:sky_cord/core/theme/app_text_styles.dart';
import 'package:sky_cord/features/chat/presentation/views/chat_view.dart';
import 'package:sky_cord/features/chat/presentation/widgets/chat_avatar.dart';

class ChatCard extends StatelessWidget {
  final String otherUserId;
  final String username;
  final String lastMessage;
  final String time;
  final String? pfp;

  const ChatCard(
      {super.key,
      required this.otherUserId,
      required this.username,
      required this.lastMessage,
      required this.time,
      this.pfp});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return StreamBuilder<DatabaseEvent>(
      stream: UserStatusService.instance.getUserStatus(otherUserId),
      builder: (context, snapshot) {
        bool isOnline = false;
        bool isTyping = false;

        if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
          final data =
              Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
          isOnline = data["online"] ?? false;
          isTyping = data["typing"] ?? false;
        }

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatView(
                  otherUserId: otherUserId,
                  username: username,
                  pfp: pfp,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Stack(
                  children: [
                    ChatAvatar(
                      username: username,
                      pfp: pfp,
                      radius: 28,
                    ),
                    if (isOnline)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            color: AppColors.greenColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.whiteColor, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: AppTextStyles.bold16White
                            .copyWith(color: onSurface),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      if (isTyping)
                        const Text(
                          "Typing...",
                          style: AppTextStyles.medium14Green,
                        )
                      else
                        Text(
                          lastMessage,
                          style: AppTextStyles.medium14Grey,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  time,
                  style:
                      AppTextStyles.regular14Black.copyWith(color: onSurface),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
