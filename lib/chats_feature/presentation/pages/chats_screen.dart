import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/chats_feature/manager/get_all_users_cubit/get_all_users_cubit.dart';
import 'package:social_application/chats_feature/manager/get_all_users_cubit/get_all_users_states.dart';
import 'package:social_application/chats_feature/presentation/widgets/build_chat_item.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllUsersCubit, GetAllUsersStates>(
        builder: (context, state) {
          return GetAllUsersCubit.get(context).users.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => BuildChatItem(
                    model: GetAllUsersCubit.get(context).users[index],
                  ),
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey[200],
                  ),
                  itemCount: GetAllUsersCubit.get(context).users.length - 1,
                )
              : const Center(child: CircularProgressIndicator());
        },
      );
  }
}
