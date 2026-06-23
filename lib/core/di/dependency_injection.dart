import 'package:get_it/get_it.dart';
import 'package:sky_cord/core/services/auth_service.dart';
import 'package:sky_cord/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:sky_cord/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sky_cord/features/auth/domain/repositories/auth_repository.dart';
import 'package:sky_cord/features/auth/domain/usecases/login_use_case.dart';
import 'package:sky_cord/features/auth/domain/usecases/register_use_case.dart';
import 'package:sky_cord/features/auth/presentation/provider/app_auth_provider.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<AuthService>(() => AuthService.instance);

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<AuthService>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory<AppAuthProvider>(
    () => AppAuthProvider(getIt<LoginUseCase>(), getIt<RegisterUseCase>()),
  );
}
