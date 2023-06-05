import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_application/home_feature/presentation/widgets/build_post_item.dart';

class Posts extends StatelessWidget {
  const Posts({
    super.key, required this.uId,
  });
final String uId;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('posts')
            .where('uId', isEqualTo: uId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
            snapshot.data?.docs[index].data()['uId'] == uId
                ? BuildPostItem(
              snap: snapshot.data?.docs[index].data(),
            )
                : const SizedBox(),
            separatorBuilder: (context, index) => const SizedBox(
              height: 8.0,
            ),
            itemCount: snapshot.data?.docs.length ?? 3,
          );
        });
  }
}