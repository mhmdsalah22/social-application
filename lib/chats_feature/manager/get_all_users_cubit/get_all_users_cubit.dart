import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/auth_feature/data/models/create_user_model.dart';
import 'package:social_application/core/utiles/contants.dart';

import 'get_all_users_states.dart';

class GetAllUsersCubit extends Cubit<GetAllUsersStates> {
  GetAllUsersCubit() : super(InitialState());

  static GetAllUsersCubit get(BuildContext context) => BlocProvider.of(context);

  List<SocialUserModel> users = [];

  void getAllUsers() {
    if(users.length == 0) {
      emit(LoadingGetAllUsersState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        }
        emit(SuccessGetAllUsersState());
      }).catchError((error) {
        emit(ErrorGetAllUsersState(error.toString()));
      });
    }
  }
}
