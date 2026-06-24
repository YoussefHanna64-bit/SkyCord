import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_cord/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:sky_cord/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;

  ChatRepositoryImpl(this._remoteDataSource);

  @override
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _remoteDataSource.getUsersStream();
  }

  @override
  Future<void> sendMessage(String receiverId, String message) {
    return _remoteDataSource.sendMessage(receiverId, message);
  }

  @override
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    return _remoteDataSource.getMessages(userId, otherUserId);
  }

  @override
  Stream<DocumentSnapshot> getChatRoomStream(
      String userId, String otherUserId) {
    return _remoteDataSource.getChatRoomStream(userId, otherUserId);
  }
}
