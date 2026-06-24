import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/core/utils/result.dart';
import 'package:sky_cord/features/chat/domain/usecases/get_chat_room_stream_use_case.dart';
import 'package:sky_cord/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:sky_cord/features/chat/domain/usecases/get_users_stream_use_case.dart';
import 'package:sky_cord/features/chat/domain/usecases/send_message_use_case.dart';

class ChatProvider {
  final GetUsersStreamUseCase _getUsersStreamUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final GetMessagesUseCase _getMessagesUseCase;
  final GetChatRoomStreamUseCase _getChatRoomStreamUseCase;

  ChatProvider(this._getUsersStreamUseCase, this._sendMessageUseCase,
      this._getMessagesUseCase, this._getChatRoomStreamUseCase);

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _getUsersStreamUseCase();
  }

  Future<Result<void>> sendMessage(String receiverId, String message) async {
    try {
      await _sendMessageUseCase(receiverId, message);
      return Result.success(data: null);
    } on FirebaseException catch (e) {
      debugPrint("Firebase Error sending message: ${e.message}");
      return Result.failure(message: e.message ?? "Failed to send message");
    }
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    return _getMessagesUseCase(userId, otherUserId);
  }

  Stream<DocumentSnapshot> getChatRoomStream(
      String userId, String otherUserId) {
    return _getChatRoomStreamUseCase(userId, otherUserId);
  }
}
