import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'package:social_application/home_feature/manager/like_post_cubit/like_post_states.dart';

class LikePostCubit extends Cubit<LikePostStates> {
  LikePostCubit() : super(InitialState());

  static LikePostCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> likePost({
    required String postId,
    required List likes,
  }) async {
    try {
      if (likes.contains(uId)) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({
          'likes': FieldValue.arrayRemove([uId]),
        });
        emit(SuccessRemoveLikeState());
      } else {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({
          'likes': FieldValue.arrayUnion([uId]),
        });
        emit(SuccessAddLikeState());
      }
    } catch (e) {
      print(e.toString());
      emit(ErrorLikeState(e.toString()));
    }
  }
}
