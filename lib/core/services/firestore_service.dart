import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/core/models/app_user.dart';
import 'package:sky_cord/core/models/chat_message.dart';

class FirestoreService {
  FirestoreService._();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirestoreService instance = FirestoreService._();

  Future<void> setUserProfileData(AppUser user) async {
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(user.toMap());
    } on FirebaseException catch (e) {
      debugPrint("Error setting user profile data: ${e.message}");
      rethrow;
    }
  }

  Future<AppUser> getUserProfileData(String userId) async {
    DocumentSnapshot doc =
        await _firebaseFirestore.collection("users").doc(userId).get();
    final mapData = doc.data() as Map<String, dynamic>;
    return AppUser.fromMap(mapData);
  }

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firebaseFirestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) => doc.id != _auth.currentUser?.uid)
          .map((doc) {
        final data = doc.data();
        data['uid'] = doc.id;
        return data;
      }).toList();
    });
  }

  String getChatRoomId(String userId1, String userId2) {
    List<String> ids = [userId1, userId2];
    ids.sort();
    return ids.join("_");
  }

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    ChatMessage newMessage = ChatMessage(
      senderId: currentUserId,
      text: message,
      timestamp: timestamp,
    );

    String chatRoomId = getChatRoomId(currentUserId, receiverId);

    await _firebaseFirestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());

    await _firebaseFirestore.collection("chat_rooms").doc(chatRoomId).set({
      "participants": [currentUserId, receiverId],
      "lastMessage": message,
      "lastTimestamp": timestamp,
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    String chatRoomId = getChatRoomId(userId, otherUserId);

    return _firebaseFirestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Stream<DocumentSnapshot> getChatRoomStream(String userId, String otherUserId) {
    String chatRoomId = getChatRoomId(userId, otherUserId);
    return _firebaseFirestore.collection("chat_rooms").doc(chatRoomId).snapshots();
  }
}
