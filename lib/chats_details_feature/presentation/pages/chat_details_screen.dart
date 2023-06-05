import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/auth_feature/data/models/create_user_model.dart';
import 'package:social_application/chats_details_feature/manager/get_message_cubit/get_message_cubit.dart';
import 'package:social_application/chats_details_feature/manager/get_message_cubit/get_message_states.dart';
import 'package:social_application/chats_details_feature/manager/send_message_cubit/send_message_cubit.dart';
import 'package:social_application/chats_details_feature/manager/send_message_cubit/send_message_states.dart';
import 'package:social_application/chats_feature/data/models/message_model.dart';
import 'package:social_application/chats_feature/presentation/widgets/call_sceen.dart';
import 'package:social_application/chats_feature/presentation/widgets/video_screen.dart';
import 'package:social_application/core/styles/icon_broken.dart';
import 'package:social_application/core/utiles/contants.dart';

class ChatDetailScreen extends StatelessWidget {
  ChatDetailScreen({
    Key? key,
    required this.model,
  }) : super(key: key);
  final SocialUserModel model;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      GetMessageCubit.get(context).getMessage(receiverId: model.uId);
      return BlocBuilder<GetMessageCubit, GetMessageStates>(
        builder: (context, state) {
          return BlocBuilder<SendMessageCubit, SendMessageStates>(
            builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(
                    titleSpacing: 0.0,
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(model.image),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            model.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CallPage(callID: uId!, model: model),
                            ),
                          );
                        },
                        icon: const Icon(
                          IconBroken.Call,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoPage(
                                      callID: model.uId, model: model)));
                        },
                        icon: const Icon(
                          IconBroken.Video,
                        ),
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              reverse: false,
                              itemBuilder: (context, index) {
                                final message = GetMessageCubit.get(context)
                                    .messages[index];
                                if (uId == message.senderId) {
                                  return buildMyMessage(message);
                                }
                                return buildMessage(message);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 15,
                                  ),
                              itemCount:
                                  GetMessageCubit.get(context).messages.length),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: TextFormField(
                                    controller: _textEditingController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type your message here ...',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 55,
                                color: defaultColor,
                                child: MaterialButton(
                                  onPressed: () {
                                    SendMessageCubit.get(context).sendMessage(
                                      receiverId: model.uId,
                                      dateTime: Timestamp.now().toString(),
                                      text: _textEditingController.text,
                                    );
                                    _textEditingController.clear();
                                  },
                                  minWidth: 1,
                                  child: const Icon(
                                    IconBroken.Send,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          );
        },
      );
    });
  }

  Align buildMyMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),
          color: defaultColor.withOpacity(0.2),
        ),
        child: Text(
          model.text,
        ),
      ),
    );
  }

  Align buildMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),
          color: Colors.grey[300],
        ),
        child: Text(
          model.text,
        ),
      ),
    );
  }
}
