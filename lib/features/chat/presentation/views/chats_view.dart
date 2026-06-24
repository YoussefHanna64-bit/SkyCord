import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/core/di/dependency_injection.dart';
import 'package:sky_cord/core/theme/app_text_styles.dart';
import 'package:sky_cord/features/chat/presentation/provider/chat_provider.dart';
import 'package:sky_cord/features/chat/presentation/widgets/chat_card.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  final ChatProvider _chatProvider = getIt<ChatProvider>();
  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chats",
            style: AppTextStyles.bold20Grey.copyWith(color: onSurface)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatProvider.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error loading chats: ${snapshot.error}",
                style: AppTextStyles.medium14Grey,
              ),
            );
          }

          final List<Map<String, dynamic>> users = snapshot.data ?? [];

          if (users.isEmpty) {
            return const Center(
              child: Text(
                "No users found.",
                style: AppTextStyles.medium14Grey,
              ),
            );
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final currentUserId = FirebaseAuth.instance.currentUser!.uid;
              return StreamBuilder<DocumentSnapshot>(
                stream:
                    _chatProvider.getChatRoomStream(currentUserId, user["uid"]),
                builder: (context, chatSnapshot) {
                  String displayMessage = "Tap to start chatting";
                  String displayTime = "";

                  if (chatSnapshot.hasData && chatSnapshot.data!.exists) {
                    final chatData =
                        chatSnapshot.data!.data() as Map<String, dynamic>;
                    displayMessage = chatData["lastMessage"] ?? displayMessage;

                    if (chatData["lastTimestamp"] != null) {
                      final timestamp = chatData["lastTimestamp"] as Timestamp;
                      final dateTime = timestamp.toDate();
                      displayTime =
                          "${dateTime.hour}:${dateTime.minute.toString()}";
                    }
                  }

                  return ChatCard(
                    otherUserId: user["uid"],
                    username: user["username"] ?? "Unknown",
                    lastMessage: displayMessage,
                    time: displayTime,
                    pfp: user["pfp"],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
