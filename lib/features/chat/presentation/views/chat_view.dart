import 'package:flutter/material.dart';
import 'package:sky_cord/core/di/dependency_injection.dart';
import 'package:sky_cord/core/theme/app_text_styles.dart';
import 'package:sky_cord/features/chat/presentation/provider/chat_provider.dart';
import 'package:sky_cord/features/chat/presentation/widgets/chat_card.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatProvider _chatProvider = getIt<ChatProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats", style: AppTextStyles.bold20Grey),
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

              return ChatCard(
                otherUserID: user["uid"],
                username: user["username"] ?? "Unknown",
                lastMessage: "Tap to start chatting",
                time: "",
                pfp: user["pfp"],
              );
            },
          );
        },
      ),
    );
  }
}
