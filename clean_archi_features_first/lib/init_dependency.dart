import 'package:clean_archi_features_first/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean_archi_features_first/core/secrets/app_secrets.dart';
import 'package:clean_archi_features_first/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_archi_features_first/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean_archi_features_first/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_archi_features_first/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:clean_archi_features_first/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:clean_archi_features_first/features/auth/domain/usecases/user_singup_usecase.dart';
import 'package:clean_archi_features_first/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSingupUsecase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserLoginUsecase(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetCurrentUserUsecase(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      getCurrentUserUsecase: serviceLocator(),
      userLoginUsecase: serviceLocator(),
      userSingupUsecase: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}
