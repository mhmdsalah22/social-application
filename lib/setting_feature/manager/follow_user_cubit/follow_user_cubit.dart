import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'package:social_application/setting_feature/manager/follow_user_cubit/follow_user_states.dart';

class FollowUserCubit extends Cubit<FollowUserStates> {
  FollowUserCubit() : super(InitialState());

  static FollowUserCubit get(BuildContext context) => BlocProvider.of(context);

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void followUser({
    required String followId,
  }) {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      List following = value.data()?['following'];
      if (following.contains(followId)) {
        FirebaseFirestore.instance.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uId]),
        });
        FirebaseFirestore.instance.collection('users').doc(uId).update({
          'following': FieldValue.arrayRemove([followId]),
        });
        emit(SuccessRemoveFollowUserState());
      } else {
        FirebaseFirestore.instance.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uId]),
        });
        FirebaseFirestore.instance.collection('users').doc(uId).update({
          'following': FieldValue.arrayUnion([followId]),
        });
        emit(SuccessAddFollowUserState());
      }
    }).catchError((error) {
      emit(ErrorFollowUserState(error.toString()));
    });
  }
}
