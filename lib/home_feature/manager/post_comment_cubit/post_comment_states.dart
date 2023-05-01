import 'package:social_application/comments_feature/data/models/comment_model.dart';

abstract class PostCommentStates{}

class InitialState extends PostCommentStates{}

class SuccessPostCommentState extends PostCommentStates{
  final CommentModel model;

  SuccessPostCommentState(this.model);
}

class ErrorPostCommentState extends PostCommentStates{
  final String error;

  ErrorPostCommentState(this.error);
}