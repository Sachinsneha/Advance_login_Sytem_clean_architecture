import 'package:clean_archi_features_first/core/error/exception.dart';
import 'package:clean_archi_features_first/features/auth/data/model/user_profile_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserProfileModel> singUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserProfileModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserProfileModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;
  @override
  Future<UserProfileModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            );
        return UserProfileModel.fromJson(userData.first);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserProfileModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserProfileModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserProfileModel> singUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      print("Attempting to sign up user...");
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );
      print("Response: ${response.user}");
      if (response.user == null) {
        throw ServerException('User is null');
      }
      final userId = response.user!.id;
      print("User signed up successfully. User ID: $userId");

      return UserProfileModel.fromJson(response.user!.toJson());
    } catch (e) {
      print("Error during sign up: $e");
      throw ServerException(e.toString());
    }
  }
}
