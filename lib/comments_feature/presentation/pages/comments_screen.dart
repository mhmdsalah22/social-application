import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/comments_feature/presentation/widgets/comment_card.dart';
import 'package:social_application/core/styles/icon_broken.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'package:social_application/home_feature/manager/get_comment_cubit/get_comment_cubit.dart';
import 'package:social_application/home_feature/manager/get_comment_cubit/get_comments_states.dart';
import 'package:social_application/home_feature/manager/post_comment_cubit/post_comment_cubit.dart';
import 'package:social_application/new_post_feature/manager/user_info_cubit/user_info_cubit.dart';
import 'package:social_application/new_post_feature/manager/user_info_cubit/user_info_states.dart';

class CommentsScreen extends StatelessWidget {
  final String postId;

  CommentsScreen({Key? key, required this.postId}) : super(key: key);
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCommentCubit()..getComments(postId: postId),
      child: BlocProvider(
        create: (context) => GetUserInfoCubit()..getUerInfo(),
        child: BlocBuilder<GetCommentCubit, GetCommentsStates>(
          builder: (context, state) {
            return BlocBuilder<GetUserInfoCubit, GetUserInfoStates>(
              builder: (context, state) {
                if (state is SuccessGetUserInfoState) {
                  return Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(IconBroken.Arrow___Left_2)),
                      titleSpacing: 5.0,
                      title: const Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    body: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(postId)
                          .collection('comments')
                          .orderBy('datePublished', descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return ListView.separated(
                          itemBuilder: (context, index) => CommentCard(
                            snap: snapshot.data.docs[index],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 7,
                          ),
                          itemCount: (snapshot.data).docs.length,
                        );
                      },
                    ),
                    bottomNavigationBar: SafeArea(
                      child: Container(
                        height: kToolbarHeight,
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 8,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(state.model.image),
                              radius: 20,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 8),
                                child: TextField(
                                  controller: _commentController,
                                  decoration: const InputDecoration(
                                    hintText: 'write a comment ...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                PostCommentCubit.get(context).postComment(
                                  postId: postId,
                                  text: _commentController.text,
                                  uId: uId!,
                                );
                                _commentController.clear();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 8,
                                ),
                                child: const Text(
                                  'Post',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Container(
                    color: Colors.white,
                    child: const Center(child: CircularProgressIndicator()));
              },
            );
          },
        ),
      ),
    );
  }
}
