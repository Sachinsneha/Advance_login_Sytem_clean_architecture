import 'package:clean_archi_features_first/core/error/failure.dart';
import 'package:clean_archi_features_first/core/usecase/usecase.dart';

import 'package:clean_archi_features_first/core/entities/user_profile.dart';
import 'package:clean_archi_features_first/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLoginUsecase implements Usecase<UserProfile, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLoginUsecase({required this.authRepository});

  @override
  Future<Either<Failure, UserProfile>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmaiPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
