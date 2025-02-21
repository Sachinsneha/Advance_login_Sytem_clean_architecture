import 'package:clean_archi_features_first/core/error/failure.dart';
import 'package:clean_archi_features_first/core/entities/user_profile.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserProfile>> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserProfile>> loginWithEmaiPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserProfile>> currentUser();
}
