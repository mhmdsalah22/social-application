import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_application/comments_feature/presentation/pages/comments_screen.dart';
import 'package:social_application/core/styles/icon_broken.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'package:social_application/home_feature/manager/get_comment_cubit/get_comment_cubit.dart';
import 'package:social_application/home_feature/manager/get_comment_cubit/get_comments_states.dart';
import 'package:social_application/home_feature/manager/like_post_cubit/like_post_cubit.dart';
import 'package:social_application/home_feature/manager/like_post_cubit/like_post_states.dart';
import 'package:social_application/home_feature/presentation/widgets/data_of_the_user_who_posted_the_post.dart';
import 'package:social_application/home_feature/presentation/widgets/hashtag.dart';
import 'package:social_application/home_feature/presentation/widgets/image_for_post.dart';
import 'package:social_application/home_feature/presentation/widgets/image_user_in_comment.dart';
import 'package:social_application/new_post_feature/manager/create_post_cubit/create_post_states.dart';
import 'package:social_application/new_post_feature/manager/user_info_cubit/user_info_cubit.dart';
import '../../../new_post_feature/manager/create_post_cubit/create_post_cubit.dart';
import 'the_number_of_likes_and_comments.dart';

class BuildPostItem extends StatefulWidget {
  const BuildPostItem({
    super.key,
    this.snap,
  });

  final snap;

  @override
  State<BuildPostItem> createState() => _BuildPostItemState();
}

class _BuildPostItemState extends State<BuildPostItem> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetUserInfoCubit()..getUerInfo(),
      child: BlocProvider(
        create: (context) =>
            CreateNewPostCubit()..getPost(postId: widget.snap['postId']),
        child: BlocProvider(
          create: (context) => GetCommentCubit()
            ..getComments(
              postId: widget.snap['postId'],
            ),
          child: BlocBuilder<GetCommentCubit, GetCommentsStates>(
            builder: (context, state) {
              return BlocBuilder<LikePostCubit, LikePostStates>(
                builder: (context, state) {
                  return BlocBuilder<CreateNewPostCubit, CreateNewPostStates>(
                    builder: (context, state) {
                      if (state is GetPostSuccessState) {
                        return Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DataOfTheUserWhoPostedThePost(
                                  widget: widget,
                                  state: state,
                                  snap: widget.snap,
                                ),
                                line(),
                                buildText(context),
                                const HashtagInPost(),
                                if (widget.snap['postImage'] != '')
                                  ImageForPost(
                                    snap: widget.snap,
                                  ),
                                TheNumberOfLikesAndComments(
                                  snap: widget.snap,
                                ),
                                buildLineGrey(),
                                Row(
                                  children: [
                                    commentButton(context),
                                    likeButton(context),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  InkWell likeButton(BuildContext context) {
    return InkWell(
      child: Icon(
        IconBroken.Heart,
        size: 22.0,
        color: widget.snap['likes'].contains(uId) ? Colors.red : Colors.grey,
      ),
      onTap: () {
        LikePostCubit.get(context).likePost(
          postId: widget.snap['postId'],
          likes: widget.snap['likes'],
        );
      },
    );
  }

  Expanded commentButton(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Row(
          children: [
            const ImageUserInComment(),
            const SizedBox(
              width: 15.0,
            ),
            Text(
              'write a comment ...',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommentsScreen(
                postId: widget.snap['postId'].toString(),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding buildLineGrey() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  Text buildText(BuildContext context) {
    return Text(
      widget.snap['text'],
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Padding line() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  Text dateTimeForPost(BuildContext context) {
    return Text(
      DateFormat.yMMMd().format(DateTime.tryParse(widget.snap['dateTime'])!),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            height: 1.4,
          ),
    );
  }
}
//w