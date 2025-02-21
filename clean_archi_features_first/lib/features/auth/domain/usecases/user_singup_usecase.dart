import 'package:clean_archi_features_first/core/error/failure.dart';
import 'package:clean_archi_features_first/core/usecase/usecase.dart';
import 'package:clean_archi_features_first/core/entities/user_profile.dart';
import 'package:clean_archi_features_first/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSingupUsecase implements Usecase<UserProfile, UserSingupParams> {
  final AuthRepository authRepository;

  UserSingupUsecase(this.authRepository);

  @override
  Future<Either<Failure, UserProfile>> call(UserSingupParams params) async {
    return await authRepository.singUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSingupParams {
  final String name;
  final String email;
  final String password;

  UserSingupParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
