import 'package:flutter/material.dart';
import 'package:social_application/comments_feature/presentation/pages/comments_screen.dart';
import 'package:social_application/core/styles/icon_broken.dart';
import 'package:social_application/home_feature/manager/get_comment_cubit/get_comment_cubit.dart';

class TheNumberOfLikesAndComments extends StatelessWidget {
  final snap;

  const TheNumberOfLikesAndComments({Key? key, required this.snap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      '${snap['likes'].length} likes',
                      style: Theme.of(context).textTheme.bodySmall,
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
                  mainAxisAlignment: MainAxisAlignment.end,
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
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      postId: snap['postId'].toString(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
