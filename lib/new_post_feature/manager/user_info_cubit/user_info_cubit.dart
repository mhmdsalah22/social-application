import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/auth_feature/data/models/create_user_model.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'package:social_application/new_post_feature/manager/user_info_cubit/user_info_states.dart';

class GetUserInfoCubit extends Cubit<GetUserInfoStates>
{
  GetUserInfoCubit(): super(InitialState());

  static GetUserInfoCubit get(BuildContext context)=>BlocProvider.of(context);

  void getUerInfo(){
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      emit(SuccessGetUserInfoState(
          model: SocialUserModel.fromJson(value.data()!)));
    }).catchError((error) {
      emit(ErrorGetUserInfoState(error.toString()));
      print(error.toString());
    });
  }
}