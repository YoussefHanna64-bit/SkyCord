import 'package:get_it/get_it.dart';
import 'package:sky_cord/core/services/auth_service.dart';
import 'package:sky_cord/core/services/firestore_service.dart';
import 'package:sky_cord/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:sky_cord/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sky_cord/features/auth/domain/repositories/auth_repository.dart';
import 'package:sky_cord/features/auth/domain/usecases/login_use_case.dart';
import 'package:sky_cord/features/auth/domain/usecases/logout_use_case.dart';
import 'package:sky_cord/features/auth/domain/usecases/register_use_case.dart';
import 'package:sky_cord/features/auth/presentation/provider/app_auth_provider.dart';
import 'package:sky_cord/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:sky_cord/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:sky_cord/features/chat/domain/repositories/chat_repository.dart';
import 'package:sky_cord/features/chat/domain/usecases/get_users_stream_use_case.dart';
import 'package:sky_cord/features/chat/presentation/provider/chat_provider.dart';
import 'package:sky_cord/features/profile/presentation/provider/profile_provider.dart';

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

  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory<AppAuthProvider>(
    () => AppAuthProvider(getIt<LoginUseCase>(), getIt<RegisterUseCase>()),
  );

  getIt
      .registerLazySingleton<FirestoreService>(() => FirestoreService.instance);

  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSource(getIt<FirestoreService>()),
  );

  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(getIt<ChatRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetUsersStreamUseCase>(
    () => GetUsersStreamUseCase(getIt<ChatRepository>()),
  );

  getIt.registerFactory<ChatProvider>(
    () => ChatProvider(getIt<GetUsersStreamUseCase>()),
  );

  getIt.registerFactory<ProfileProvider>(
    () => ProfileProvider(getIt<LogoutUseCase>()),
  );
}
