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
import 'package:social_application/home_feature/presentation/widgets/delete_post.dart';
import 'package:social_application/home_feature/presentation/widgets/image_user_in_comment.dart';
import 'package:social_application/home_feature/presentation/widgets/image_user_in_post.dart';
import 'package:social_application/home_feature/presentation/widgets/like_animation.dart';
import 'package:social_application/home_feature/presentation/widgets/username_for_post.dart';
import 'package:social_application/new_post_feature/manager/create_post_cubit/create_post_states.dart';
import 'package:social_application/new_post_feature/manager/user_info_cubit/user_info_cubit.dart';
import '../../../new_post_feature/manager/create_post_cubit/create_post_cubit.dart';

class BuildPostItem extends StatefulWidget {
  BuildPostItem({
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
                                Row(
                                  children: [
                                    ImageUserInPost(
                                      widget: widget,
                                      model: state.model,
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              UserNameForPost(
                                                widget: widget,
                                                model: state.model,
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Icon(
                                                Icons.check_circle,
                                                color: defaultColor,
                                                size: 16.0,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            DateFormat.yMMMd().format(
                                                DateTime.tryParse(
                                                    widget.snap['dateTime'])!),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  height: 1.4,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    DeletePost(
                                      snap: widget.snap,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Text(
                                  widget.snap['text'],
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10.0,
                                    top: 5.0,
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                            end: 6.0,
                                          ),
                                          child: SizedBox(
                                            height: 25.0,
                                            child: MaterialButton(
                                              onPressed: () {},
                                              minWidth: 1.0,
                                              padding: EdgeInsets.zero,
                                              child: Text(
                                                '#software',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: defaultColor,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                            end: 6.0,
                                          ),
                                          child: SizedBox(
                                            height: 25.0,
                                            child: MaterialButton(
                                              onPressed: () {},
                                              minWidth: 1.0,
                                              padding: EdgeInsets.zero,
                                              child: Text(
                                                '#flutter',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: defaultColor,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (widget.snap['postImage'] != '')
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 15,
                                    ),
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        LikePostCubit.get(context).likePost(
                                            postId: widget.snap['postId'],
                                            likes: widget.snap['likes']);
                                        setState(() {
                                          isLikeAnimating = true;
                                        });
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 250.0,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                4.0,
                                              ),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  widget.snap['postImage'],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            opacity: isLikeAnimating ? 1 : 0,
                                            child: LikeAnimation(
                                                isAnimating: isLikeAnimating,
                                                duration: const Duration(
                                                    milliseconds: 400),
                                                onEnd: () {
                                                  setState(() {
                                                    isLikeAnimating = false;
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                  size: 150,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5.0,
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  IconBroken.Heart,
                                                  size: 16.0,
                                                  color: Colors.red,
                                                ),
                                                const SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  '${widget.snap['likes'].length} likes',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  IconBroken.Chat,
                                                  size: 16.0,
                                                  color: Colors.amber,
                                                ),
                                                const SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  '${GetCommentCubit.get(context).commentLen} comment',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentsScreen(
                                                  postId: widget.snap['postId']
                                                      .toString(),
                                                  // index: widget.index,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10.0,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        child: Row(
                                          children: [
                                            const ImageUserInComment(),
                                            const SizedBox(
                                              width: 15.0,
                                            ),
                                            Text(
                                              'write a comment ...',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CommentsScreen(
                                                postId: widget.snap['postId']
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    InkWell(
                                      child: Icon(
                                        IconBroken.Heart,
                                        size: 22.0,
                                        color:
                                            widget.snap['likes'].contains(uId)
                                                ? Colors.red
                                                : Colors.grey,
                                      ),
                                      onTap: () {
                                        LikePostCubit.get(context).likePost(
                                          postId: widget.snap['postId'],
                                          likes: widget.snap['likes'],
                                        );
                                      },
                                    ),
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
}
