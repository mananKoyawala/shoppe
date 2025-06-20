import 'package:shoppe/models/user_profile_model.dart';

class UserLoginModel {
  final UserProfileModel user_profile;

  UserLoginModel({required this.user_profile});

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(user_profile: UserProfileModel.fromJson(json));
  }
}
