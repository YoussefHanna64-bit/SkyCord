import 'package:sky_cord/features/chat/domain/usecases/get_users_stream_use_case.dart';

class ChatProvider {
  final GetUsersStreamUseCase _getUsersStreamUseCase;

  ChatProvider(this._getUsersStreamUseCase);

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _getUsersStreamUseCase();
  }
}
