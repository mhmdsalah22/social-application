import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_application/comments_feature/presentation/widgets/name_in_comment_card.dart';
import 'package:social_application/comments_feature/presentation/widgets/profile_image_in_comment_card.dart';


class CommentCard extends StatelessWidget {
  final snap;
   const CommentCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var datePublished = DateTime.tryParse(snap['datePublished'].toString());
    var formattedDate = datePublished != null ? DateFormat.yMMMd().format(datePublished) : '';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          ProfileImageInCommentCard(
            snap: snap,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NameAndTextInCommentCard(
                    snap: snap,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.favorite,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
