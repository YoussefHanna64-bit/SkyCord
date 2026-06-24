import 'package:sky_cord/core/models/app_user.dart';
import 'package:sky_cord/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:sky_cord/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<AppUser> getUserProfile(String uid) {
    return _remoteDataSource.getUserProfile(uid);
  }

  @override
  Future<void> updateUserProfile(AppUser user) {
    return _remoteDataSource.updateUserProfile(user);
  }
}
