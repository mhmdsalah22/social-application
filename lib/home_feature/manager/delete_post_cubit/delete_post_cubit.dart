import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/home_feature/manager/delete_post_cubit/delete_post_states.dart';

class DeletePostCubit extends Cubit<DeletePostStates>{
  DeletePostCubit():super(InitialState());

  static DeletePostCubit get(BuildContext context)=>BlocProvider.of(context);

  Future deletePost({
    required String postId,
})async{
    try{
      await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
      emit(SuccessDeletePostState());
    }catch(error){
      print(error.toString());
      emit(ErrorDeletePostState(error.toString()));
    }
  }
}