import 'package:clean_archi_features_first/core/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
