import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/chats_details_feature/manager/send_message_cubit/send_message_states.dart';
import 'package:social_application/chats_feature/data/models/message_model.dart';
import 'package:social_application/core/utiles/contants.dart';

class SendMessageCubit extends Cubit<SendMessageStates> {
  SendMessageCubit() : super(InitialState());

  static SendMessageCubit get(BuildContext context) => BlocProvider.of(context);

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        senderId: uId!, receiverId: receiverId, dateTime: dateTime, text: text);


    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError((error) {
      emit(ErrorSendMessageState(error.toString()));
    });

  FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError((error) {
      emit(ErrorSendMessageState(error.toString()));
    });

  }
}
