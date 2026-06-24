import 'package:sky_cord/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository _chatRepository;

  SendMessageUseCase(this._chatRepository);

  Future<void> call(String receiverId, String message) {
    return _chatRepository.sendMessage(receiverId, message);
  }
}
