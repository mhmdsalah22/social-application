import 'package:flutter/material.dart';
import 'package:social_application/home_feature/manager/like_post_cubit/like_post_cubit.dart';
import 'package:social_application/home_feature/presentation/widgets/like_animation.dart';

class ImageForPost extends StatefulWidget {
  const ImageForPost({super.key, required this.snap});

  final snap;

  @override
  State<ImageForPost> createState() => _ImageForPostState();
}

class _ImageForPostState extends State<ImageForPost> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: GestureDetector(
        onDoubleTap: () {
          LikePostCubit.get(context).likePost(
              postId: widget.snap['postId'], likes: widget.snap['likes']);
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
                borderRadius: BorderRadius.circular(
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
              duration: const Duration(milliseconds: 200),
              opacity: isLikeAnimating ? 1 : 0,
              child: LikeAnimation(
                  isAnimating: isLikeAnimating,
                  duration: const Duration(milliseconds: 400),
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
    );
  }
}
