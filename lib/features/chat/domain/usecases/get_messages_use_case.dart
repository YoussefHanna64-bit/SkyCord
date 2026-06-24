import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_cord/features/chat/domain/repositories/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository _chatRepository;

  GetMessagesUseCase(this._chatRepository);

  Stream<QuerySnapshot> call(String userId, String otherUserId) {
    return _chatRepository.getMessages(userId, otherUserId);
  }
}
