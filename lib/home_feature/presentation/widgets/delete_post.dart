import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'package:social_application/home_feature/manager/delete_post_cubit/delete_post_cubit.dart';
import 'package:social_application/home_feature/manager/delete_post_cubit/delete_post_states.dart';

class DeletePost extends StatelessWidget {
  final  snap;

  const DeletePost({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeletePostCubit, DeletePostStates>(
      builder: (context, state) {
        return snap['uId'].toString() == uId
            ? IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  size: 16.0,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ]
                                  .map(
                                    (e) => InkWell(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                          child: Text(e),
                                        ),
                                        onTap: () {
                                          DeletePostCubit.get(context)
                                              .deletePost(
                                            postId: snap['postId'].toString(),
                                          );
                                          Navigator.of(context).pop();
                                        }),
                                  )
                                  .toList()),
                        );
                      });
                },
              )
            : Container();
      },
    );
  }
}
