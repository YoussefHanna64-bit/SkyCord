import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_cord/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<User?> call(String username, String email, String password) {
    return _authRepository.register(username, email, password);
  }
}
