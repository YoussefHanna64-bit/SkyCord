import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/core/models/app_user.dart';
import 'package:sky_cord/core/utils/result.dart';
import 'package:sky_cord/features/auth/domain/usecases/logout_use_case.dart';
import 'package:sky_cord/features/profile/domain/usecases/get_user_profile_use_case.dart';
import 'package:sky_cord/features/profile/domain/usecases/update_user_profile_use_case.dart';

class ProfileProvider {
  final LogoutUseCase _logoutUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;

  ProfileProvider(this._logoutUseCase, this._getUserProfileUseCase,
      this._updateUserProfileUseCase);

  Future<Result<AppUser>> getUserData(String uid) async {
    try {
      final user = await _getUserProfileUseCase(uid);
      return Result.success(data: user);
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      return Result.failure(message: "Failed to load profile data");
    }
  }

  Future<Result<void>> updateProfile(AppUser user) async {
    try {
      await _updateUserProfileUseCase(user);
      return Result.success(data: null);
    } catch (e) {
      debugPrint("Error updating profile: $e");
      return Result.failure(message: "Failed to update profile");
    }
  }

  Future<Result<void>> logout() async {
    try {
      await _logoutUseCase();
      debugPrint("User logged out");
      return Result.success(data: null);
    } on FirebaseAuthException catch (e) {
      debugPrint("Auth Exception in logout: ${e.code} - ${e.message}");
      return Result.failure(message: e.message ?? "Failed to log out");
    }
  }
}
