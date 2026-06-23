import 'package:sky_cord/features/chat/domain/repositories/chat_repository.dart';

class GetUsersStreamUseCase {
  final ChatRepository _chatRepository;

  GetUsersStreamUseCase(this._chatRepository);

  Stream<List<Map<String, dynamic>>> call() {
    return _chatRepository.getUsersStream();
  }
}
