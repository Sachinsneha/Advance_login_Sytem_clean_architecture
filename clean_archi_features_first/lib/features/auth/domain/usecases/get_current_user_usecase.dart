import 'package:clean_archi_features_first/core/error/failure.dart';
import 'package:clean_archi_features_first/core/usecase/usecase.dart';
import 'package:clean_archi_features_first/core/entities/user_profile.dart';
import 'package:clean_archi_features_first/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUserUsecase implements Usecase<UserProfile, NoParams> {
  final AuthRepository authRepository;
  const GetCurrentUserUsecase(this.authRepository);
  @override
  Future<Either<Failure, UserProfile>> call(NoParams param) async {
    return await authRepository.currentUser();
  }
}
