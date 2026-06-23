import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:sky_cord/core/utils/result.dart';
import 'package:sky_cord/features/auth/domain/usecases/login_use_case.dart';
import 'package:sky_cord/features/auth/domain/usecases/register_use_case.dart';

class AuthProvider {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthProvider(this._loginUseCase, this._registerUseCase);

  Future<Result<User?>> login(String email, String password) async {
    try {
      User? user = await _loginUseCase(email, password);
      if (user != null) {
        debugPrint("user data ${user.uid}");
        return Result.success(data: user);
      } else {
        return Result.failure(message: "Something went wrong, Try again");
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Auth Exception ${e.code} - ${e.message}");
      return Result.failure(message: e.message);
    }
  }

  Future<Result<User?>> register(
      String username, String email, String password) async {
    try {
      User? user = await _registerUseCase(username, email, password);
      if (user != null) {
        debugPrint("user data ${user.uid}");
        return Result.success(data: user);
      } else {
        return Result.failure(message: "Something went wrong, Try again");
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Auth Exception ${e.code} - ${e.message}");
      return Result.failure(message: e.message);
    }
  }
}
