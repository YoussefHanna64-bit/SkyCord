import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_cord/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:sky_cord/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<User?> login(String email, String password) {
    return _remoteDataSource.login(email, password);
  }

  @override
  Future<User?> register(String username, String email, String password) {
    return _remoteDataSource.register(username, email, password);
  }

  @override
  Future<void> logout() {
    return _remoteDataSource.logout();
  }
}
