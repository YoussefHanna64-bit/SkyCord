import 'package:firebase_database/firebase_database.dart';

class UserStatusService {
  UserStatusService._();

  static final UserStatusService instance = UserStatusService._();

  final DatabaseReference _reference = FirebaseDatabase.instance.ref();
  final DatabaseReference _connectRef =
      FirebaseDatabase.instance.ref(".info/connected");

  void init(String userId) {
    _connectRef.onValue.listen((event) {
      final isConnected = event.snapshot.value as bool? ?? false;
      if (isConnected) {
        final userStatusRef = _reference.child("users").child(userId);
        userStatusRef.onDisconnect().update({
          "online": false,
          "last_seen": ServerValue.timestamp,
        });

        setOnline(userId);
      }
    });
  }

  Stream<bool> getConnectionStatus() {
    return _connectRef.onValue.map((event) {
      return event.snapshot.value as bool? ?? false;
    });
  }

  Future<void> setOnline(String userId) async {
    await _reference.child("users").child(userId).update({
      "online": true,
    });
  }

  Stream<DatabaseEvent> getUserStatus(String userId) {
    return _reference.child("users").child(userId).onValue;
  }

  Future<void> setTyping(String userId, bool typing) async {
    await _reference.child("users").child(userId).update({"typing": typing});
  }
}
