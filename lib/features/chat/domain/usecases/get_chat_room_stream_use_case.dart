import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_cord/features/chat/domain/repositories/chat_repository.dart';

class GetChatRoomStreamUseCase {
  final ChatRepository _chatRepository;

  GetChatRoomStreamUseCase(this._chatRepository);

  Stream<DocumentSnapshot> call(String userId, String otherUserId) {
    return _chatRepository.getChatRoomStream(userId, otherUserId);
  }
}
