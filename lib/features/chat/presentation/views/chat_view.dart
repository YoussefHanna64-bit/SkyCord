import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/core/di/dependency_injection.dart';
import 'package:sky_cord/core/services/user_status_service.dart';
import 'package:sky_cord/core/theme/app_colors.dart';
import 'package:sky_cord/core/theme/app_text_styles.dart';
import 'package:sky_cord/features/chat/presentation/provider/chat_provider.dart';
import 'package:sky_cord/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:sky_cord/features/chat/presentation/widgets/chat_input.dart';

class ChatView extends StatefulWidget {
  final String otherUserId;
  final String username;

  const ChatView(
      {super.key, required this.otherUserId, required this.username});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ChatProvider _chatProvider = getIt<ChatProvider>();
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  bool _isTyping = false;

  void _onTextChanged(String text) {
    if (text.trim().isNotEmpty && !_isTyping) {
      _isTyping = true;
      UserStatusService.instance.setTyping(currentUserId, true);
    } else if (text.trim().isEmpty && _isTyping) {
      _isTyping = false;
      UserStatusService.instance.setTyping(currentUserId, false);
    }
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      final text = _messageController.text;
      _messageController.clear();

      _isTyping = false;
      UserStatusService.instance.setTyping(currentUserId, false);

      await _chatProvider.sendMessage(widget.otherUserId, text);
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    UserStatusService.instance.setTyping(currentUserId, false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username,
            style: AppTextStyles.bold20Grey.copyWith(color: onSurface)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.greyColor),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  _chatProvider.getMessages(currentUserId, widget.otherUserId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading messages"));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data?.docs ?? [];

                if (messages.isEmpty) {
                  return const Center(
                    child: Text(
                      "Say hi!",
                      style: AppTextStyles.medium14Grey,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final messageData =
                        messages[index].data() as Map<String, dynamic>;
                    final isMe = messageData["senderId"] == currentUserId;

                    return ChatBubble(text: messageData["text"], isMe: isMe);
                  },
                );
              },
            ),
          ),
          ChatInput(
            controller: _messageController,
            onSend: _sendMessage,
            onTextChanged: _onTextChanged,
          ),
        ],
      ),
    );
  }
}
