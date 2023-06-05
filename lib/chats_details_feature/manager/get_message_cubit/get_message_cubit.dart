import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/chats_feature/data/models/message_model.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'get_message_states.dart';

class GetMessageCubit extends Cubit<GetMessageStates> {
  GetMessageCubit() : super(InitialState());

  static GetMessageCubit get(BuildContext context) => BlocProvider.of(context);

  List<MessageModel> messages = [];

  void getMessage({
    required String receiverId,
  }) {

      FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime',descending: true)
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SuccessGetMessageState());
    });



  }
}
