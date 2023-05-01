import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileImageInCommentCard extends StatelessWidget {
  const ProfileImageInCommentCard({super.key, required this.snap});

  final snap;

  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('uId', isEqualTo: snap['uId'])
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          for (int i = 0; i < snapshot.data!.docs.length;) {
            return CircleAvatar(
              backgroundImage:
                  NetworkImage('${snapshot.data?.docs[i].data()['image']}'),
              radius: 24,
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
