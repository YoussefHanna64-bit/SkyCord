import 'package:sky_cord/core/models/app_user.dart';
import 'package:sky_cord/core/services/firestore_service.dart';

class ProfileRemoteDataSource {
  final FirestoreService _firestoreService;

  ProfileRemoteDataSource(this._firestoreService);

  Future<AppUser> getUserProfile(String uid) {
    return _firestoreService.getUserProfileData(uid);
  }

  Future<void> updateUserProfile(AppUser user) {
    return _firestoreService.setUserProfileData(user);
  }
}
