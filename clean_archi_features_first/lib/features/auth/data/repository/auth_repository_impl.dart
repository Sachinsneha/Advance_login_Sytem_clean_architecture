// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_archi_features_first/core/error/exception.dart';
import 'package:clean_archi_features_first/core/entities/user_profile.dart';
import 'package:fpdart/fpdart.dart';

import 'package:clean_archi_features_first/core/error/failure.dart';
import 'package:clean_archi_features_first/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_archi_features_first/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(
    this.authRemoteDataSource,
  );

  @override
  Future<Either<Failure, UserProfile>> loginWithEmaiPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDataSource.singUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );

      return right(user);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      print('Repository Error: ${e.message}');
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> currentUser() async {
    try {
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('user not login'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
