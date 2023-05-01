import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/home_feature/data/models/post_model.dart';
import 'package:social_application/home_feature/presentation/widgets/build_post_item.dart';
import 'package:social_application/new_post_feature/manager/user_info_cubit/user_info_cubit.dart';
import 'package:social_application/new_post_feature/manager/user_info_cubit/user_info_states.dart';

class UserNameForPost extends StatelessWidget {
  const UserNameForPost({super.key, required this.widget, required this.model});

  final PostModel model;
  final BuildPostItem widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserInfoCubit, GetUserInfoStates>(
      builder: (context, state) {
        if (state is SuccessGetUserInfoState) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uId', isEqualTo: model.uId)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.data?.docs.isNotEmpty ?? false) {
                for (int i = 0; i < snapshot.data!.docs.length;) {
                  return Expanded(
                    child: Text(
                      snapshot.data?.docs[i].data()['name'] ?? 'Mohammed',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        height: 1.4,
                      ),
                    ),
                  );
                }
              } else {
                return const Text("List is empty");
              }
              return const SizedBox.shrink();
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
