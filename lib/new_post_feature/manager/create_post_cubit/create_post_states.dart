import 'package:social_application/auth_feature/data/models/create_user_model.dart';
import 'package:social_application/home_feature/data/models/post_model.dart';

abstract class CreateNewPostStates {}

class InitialState extends CreateNewPostStates {}

class CreatePostLoadingState extends CreateNewPostStates {}

class CreatePostSuccessState extends CreateNewPostStates {}

class CreatePostErrorState extends CreateNewPostStates {
  final String error;

  CreatePostErrorState(this.error);
}

class PostImagePickedSuccessState extends CreateNewPostStates {}

class PostImagePickedErrorState extends CreateNewPostStates {}

class RemovePostImagePickedSuccessState extends CreateNewPostStates {}

class UploadPostImageSuccessState extends CreateNewPostStates {}

class GetUserDataSuccessState extends CreateNewPostStates {
  final SocialUserModel userModel;

  GetUserDataSuccessState(this.userModel);
}

class GetUserDataErrorState extends CreateNewPostStates {
  final String error;

  GetUserDataErrorState(this.error);
}
 class GetPostSuccessState extends CreateNewPostStates{
  final PostModel model;

  GetPostSuccessState(this.model);
 }


class GetPostErrorState extends CreateNewPostStates{
  final String error;

  GetPostErrorState(this.error);
}
