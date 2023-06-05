import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/auth_feature/data/models/create_user_model.dart';
import 'package:social_application/chats_details_feature/presentation/pages/chat_details_screen.dart';
import 'package:social_application/chats_feature/manager/get_all_users_cubit/get_all_users_cubit.dart';
import 'package:social_application/chats_feature/manager/get_all_users_cubit/get_all_users_states.dart';

class BuildChatItem extends StatelessWidget {
  const BuildChatItem({
    super.key,
    required this.model,
  });
  final SocialUserModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllUsersCubit, GetAllUsersStates>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailScreen(
                  model: model,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    model.image,
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text(
                  model.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
