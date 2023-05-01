import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/comments_feature/data/models/comment_model.dart';
import 'package:social_application/home_feature/manager/post_comment_cubit/post_comment_states.dart';
import 'package:uuid/uuid.dart';

class PostCommentCubit extends Cubit<PostCommentStates> {
  PostCommentCubit() : super(InitialState());

  static PostCommentCubit get(BuildContext context) => BlocProvider.of(context);

  Future postComment({
    required String postId,
    required String text,
    required String uId,
  }) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        CommentModel model = CommentModel(
            uId: uId,
            datePublished: DateTime.now().toString(),
            text: text,
            commentId: commentId);
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set(model.toMap());
        emit(SuccessPostCommentState(model));
      } else {
        print('text is empty');
      }
    } catch (error) {
      print(error.toString());
      emit(ErrorPostCommentState(error.toString()));
    }
  }
}
