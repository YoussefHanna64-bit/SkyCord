import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_cord/core/utils/result.dart';
import 'package:sky_cord/features/auth/domain/usecases/logout_use_case.dart';

class ProfileProvider {
  final LogoutUseCase _logoutUseCase;

  ProfileProvider(this._logoutUseCase);

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
