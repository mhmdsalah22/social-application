import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_application/auth_feature/data/models/create_user_model.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'package:social_application/setting_feature/manager/get_user_cubit/get_user_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class GetUserCubit extends Cubit<GetUserStates> {
  GetUserCubit() : super(InitialState());

  static GetUserCubit get(BuildContext context) => BlocProvider.of(context);

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      emit(SocialGetUserSuccessState(
          model: SocialUserModel.fromJson(value.data()!)));
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
      print(error.toString());
    });
  }

  File? profileImage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    if (state is! SocialGetUserSuccessState) return;
    final currentState = state as SocialGetUserSuccessState;
    final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      profileImage = File(xFile.path);
      emit(ProfileImagePickedSuccessState(model: currentState.model));
    } else {
      print('No image selected');
      emit(ProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    if (state is! SocialGetUserSuccessState) return;
    final currentState = state as SocialGetUserSuccessState;
    final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      coverImage = File(xFile.path);
      emit(CoverImagePickedSuccessState(model: currentState.model));
    } else {
      print('No image selected');
      emit(CoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String email,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        if (state is! SocialGetUserSuccessState) return;
        final currentState = state as SocialGetUserSuccessState;
        emit(UploadProfileImageSuccessState(model: currentState.model));
        updateUser(
            name: name, email: email, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(UploadProfileImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState(error.toString()));
      print(error.toString());
    });
  }

  void uploadCoverImage({
    required String name,
    required String email,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        if (state is! SocialGetUserSuccessState) return;
        final currentState = state as SocialGetUserSuccessState;
        emit(UploadCoverImageSuccessState(model: currentState.model));
        updateUser(
            name: name, email: email, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(UploadCoverImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState(error.toString()));
    });
  }

  void updateUser({
    required String name,
    required String email,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    if (state is! SocialGetUserSuccessState) return;
    final currentState = state as SocialGetUserSuccessState;
    emit(UserUpdateLoadingState(model: currentState.model));

    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      bio: bio,
      uId: currentState.model.uId,
      cover: cover ?? currentState.model.cover,
      image: image ?? currentState.model.image,
      followers: [],
      following: [],
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState(error.toString()));
      print(error.toString());
    });
  }
}
