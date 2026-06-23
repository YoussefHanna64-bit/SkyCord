import 'package:sky_cord/core/services/firestore_service.dart';

class ChatRemoteDataSource {
  final FirestoreService _firestoreService;

  ChatRemoteDataSource(this._firestoreService);

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestoreService.getUsersStream();
  }
}
