import 'package:sky_cord/core/models/app_user.dart';
import 'package:sky_cord/features/profile/domain/repositories/profile_repository.dart';

class GetUserProfileUseCase {
  final ProfileRepository _profileRepository;

  GetUserProfileUseCase(this._profileRepository);

  Future<AppUser> call(String uid) {
    return _profileRepository.getUserProfile(uid);
  }
}
