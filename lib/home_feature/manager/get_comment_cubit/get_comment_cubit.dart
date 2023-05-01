import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/home_feature/manager/get_comment_cubit/get_comments_states.dart';

class GetCommentCubit extends Cubit<GetCommentsStates> {
  GetCommentCubit() : super(InitialState());

  static GetCommentCubit get(BuildContext context) => BlocProvider.of(context);
  int commentLen = 0;

  void getComments({
    required String postId,
  })  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get().then((value)
    {
      commentLen = value.docs.length;
      emit(SuccessGetCommentsState());
    }).catchError((error){
      emit(ErrorGetCommentsState(error.toString()));
      print(error.toString());
    });
  }
}



