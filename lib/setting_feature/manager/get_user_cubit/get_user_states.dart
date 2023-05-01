import 'package:social_application/auth_feature/data/models/create_user_model.dart';

abstract class GetUserStates{}


class InitialState extends GetUserStates{}

class SocialGetUserLoadingState extends GetUserStates {}

class SocialGetUserSuccessState extends GetUserStates {
  final SocialUserModel model;

  SocialGetUserSuccessState({required this.model});
}

class SocialGetUserErrorState extends GetUserStates
{
  final String error;

  SocialGetUserErrorState(this.error);
}

class ProfileImagePickedSuccessState extends SocialGetUserSuccessState {
  ProfileImagePickedSuccessState({required super.model});
}


class ProfileImagePickedErrorState extends GetUserStates {}

class CoverImagePickedSuccessState extends SocialGetUserSuccessState {
  CoverImagePickedSuccessState({required super.model});
}


class CoverImagePickedErrorState extends GetUserStates {}

class UploadProfileImageSuccessState extends SocialGetUserSuccessState {
  UploadProfileImageSuccessState({required super.model});
}

class UploadProfileImageErrorState extends GetUserStates {
  final String error;

  UploadProfileImageErrorState(this.error);

}

class UploadCoverImageSuccessState extends SocialGetUserSuccessState {
  UploadCoverImageSuccessState({required super.model});
}

class UploadCoverImageErrorState extends GetUserStates {
  final String error;

  UploadCoverImageErrorState(this.error);
}

class UserUpdateLoadingState extends SocialGetUserSuccessState {
  UserUpdateLoadingState({required super.model});
}

class UserUpdateErrorState extends GetUserStates {
  final String error;

  UserUpdateErrorState(this.error);

}