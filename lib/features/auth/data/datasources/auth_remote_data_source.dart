import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_cord/core/services/auth_service.dart';

class AuthRemoteDataSource {
  final AuthService _authService;

  AuthRemoteDataSource(this._authService);

  Future<User?> login(String email, String password) async {
    return _authService.signIn(email, password);
  }

  Future<User?> register(String username, String email, String password) async {
    return _authService.signUp(username, email, password);
  }

  Future<void> logout() async {
    return _authService.logout();
  }
}
