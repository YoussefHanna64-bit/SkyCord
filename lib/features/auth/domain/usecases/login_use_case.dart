import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_cord/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<User?> call(String email, String password) {
    return _authRepository.login(email, password);
  }
}
