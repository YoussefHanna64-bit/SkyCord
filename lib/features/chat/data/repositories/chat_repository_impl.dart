import 'package:sky_cord/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:sky_cord/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;

  ChatRepositoryImpl(this._remoteDataSource);

  @override
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _remoteDataSource.getUsersStream();
  }
}
