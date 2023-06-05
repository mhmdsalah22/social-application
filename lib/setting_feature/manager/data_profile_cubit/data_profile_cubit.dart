import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/core/utiles/contants.dart';

import 'data_profile_states.dart';

class DataForProfileCubit extends Cubit<DataForProfileStates> {
  DataForProfileCubit() : super(InitialState());

  static DataForProfileCubit get(BuildContext context) =>
      BlocProvider.of(context);

  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  Map userData = {};

  Future<void> getPostLength() async {
    try {
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uId', isEqualTo: uId)
          .get();
      postLength = postSnap.docs.length;
      emit(SuccessGetLengthPostState());
    } catch (e) {
      emit(ErrorGetLengthPostState(e.toString()));
      print(e.toString());
    }
  }

  Future<void> getFollowersAndFollowing() async {
    try {
      var userSnap =
          await FirebaseFirestore.instance.collection('users').doc(uId).get();
      userData = userSnap.data() ?? {};
      followers = userSnap.data()?['followers'].length;
      following = userSnap.data()?['following'].length;
      isFollowing = userSnap.data()?['followers'].contains(uId);
      emit(SuccessGetDataForProfileState());
    } catch (e) {
      emit(ErrorGetDataForProfileState(e.toString()));
      print(e.toString());
    }
  }

  void addFollowerButton() {
    try {
      isFollowing = true;
      followers++;
      getFollowersAndFollowing();
      emit(SuccessAddFollowState());
    } catch (e) {
      emit(ErrorAddFollowState(e.toString()));
    }
  }

  void removeFollowerButton() {
    try {
      isFollowing = false;
      followers--;
      getFollowersAndFollowing();
      emit(SuccessRemoveFollowState());
    } catch (e) {
      emit(ErrorRemoveFollowState(e.toString()));
    }
  }
}
