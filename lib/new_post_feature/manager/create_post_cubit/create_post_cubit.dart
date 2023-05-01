import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'package:social_application/home_feature/data/models/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_application/new_post_feature/manager/create_post_cubit/create_post_states.dart';
import 'package:uuid/uuid.dart';

class CreateNewPostCubit extends Cubit<CreateNewPostStates> {
  CreateNewPostCubit() : super(InitialState());

  static CreateNewPostCubit get(BuildContext context) =>
      BlocProvider.of(context);

  File? postImage;
  final picker = ImagePicker();

  Future getPostImage() async {
    final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      postImage = File(xFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(PostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
    required String name,
    required String image,
  }) {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value,);
        emit(UploadPostImageSuccessState());
      }).catchError((error) {
        emit(CreatePostErrorState(error.toString()));
        print(error.toString());
      });
    }).catchError((error) {
      emit(CreatePostErrorState(error.toString()));
    });
  }

  String postId = const Uuid().v1();
  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
      PostModel model = PostModel(
        uId: uId!,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? '',
        likes: [],
        postId: postId,
      );
      FirebaseFirestore.instance
          .collection('posts').doc(postId)
          .set(model.toMap())
          .then((value) {
        emit(CreatePostSuccessState());
      }).catchError((error) {
        emit(CreatePostErrorState(error.toString()));
      });
  }
  void getPost({
    required String postId,
}){
    FirebaseFirestore.instance.collection('posts').doc(postId).get().then((value) {
      emit(GetPostSuccessState(PostModel.fromJson(value.data()!)));
    }).catchError((error){
      emit(GetPostErrorState(error.toString()));
      print(error.toString());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImagePickedSuccessState());
  }


}
