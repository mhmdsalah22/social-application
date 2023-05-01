import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_application/home_feature/data/models/post_model.dart';
import 'package:social_application/home_feature/presentation/widgets/build_post_item.dart';


class ImageUserInPost extends StatelessWidget {
  const ImageUserInPost({
    super.key,
    required this.widget,
    required this.model,
  });

  final BuildPostItem widget;
  final PostModel model;


  @override
  Widget build(BuildContext context) {

          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uId', isEqualTo: model.uId)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.data?.docs.isNotEmpty ?? false) {
                for (int i = 0; i < snapshot.data!.docs.length;) {
                  return CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      snapshot.data?.docs[i].data()['image'] ??
                          'https://firebasestorage.googleapis.com/v0/b/social-app-90500.appspot.com/o/users%2FIMG-20230417-WA0000.jpg?alt=media&token=5b5d1ae6-f052-4d17-9db1-267750e0eae8',
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
}
