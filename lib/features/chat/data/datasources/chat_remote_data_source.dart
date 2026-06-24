import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_cord/core/services/firestore_service.dart';

class ChatRemoteDataSource {
  final FirestoreService _firestoreService;

  ChatRemoteDataSource(this._firestoreService);

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestoreService.getUsersStream();
  }

  Future<void> sendMessage(String receiverId, String message) {
    return _firestoreService.sendMessage(receiverId, message);
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    return _firestoreService.getMessages(userId, otherUserId);
  }

  Stream<DocumentSnapshot> getChatRoomStream(
      String userId, String otherUserId) {
    return _firestoreService.getChatRoomStream(userId, otherUserId);
  }
}
