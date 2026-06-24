import 'package:sky_cord/core/models/app_user.dart';
import 'package:sky_cord/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserProfileUseCase {
  final ProfileRepository _profileRepository;

  UpdateUserProfileUseCase(this._profileRepository);

  Future<void> call(AppUser user) {
    return _profileRepository.updateUserProfile(user);
  }
}
