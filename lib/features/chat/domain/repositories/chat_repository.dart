import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepository {
  Stream<List<Map<String, dynamic>>> getUsersStream();
  Future<void> sendMessage(String receiverId, String message);
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId);
  Stream<DocumentSnapshot> getChatRoomStream(String userId, String otherUserId);
}
