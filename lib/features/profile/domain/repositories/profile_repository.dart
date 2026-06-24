import 'package:sky_cord/core/models/app_user.dart';

abstract class ProfileRepository {
  Future<AppUser> getUserProfile(String uid);
  Future<void> updateUserProfile(AppUser user);
}
