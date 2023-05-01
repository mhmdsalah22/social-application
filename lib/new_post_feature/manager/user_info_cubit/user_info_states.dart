import 'package:social_application/auth_feature/data/models/create_user_model.dart';

abstract class GetUserInfoStates{}

class InitialState extends GetUserInfoStates{}

class SuccessGetUserInfoState extends GetUserInfoStates{
  final SocialUserModel model;

  SuccessGetUserInfoState({required this.model});
}

class ErrorGetUserInfoState extends GetUserInfoStates{
  final String error;

  ErrorGetUserInfoState(this.error);
}