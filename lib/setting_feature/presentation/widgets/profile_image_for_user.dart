import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileImageForUser extends StatelessWidget {
  const ProfileImageForUser({
    super.key, required this.uId,
  });
  final String uId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('uId', isEqualTo: uId)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.data?.docs.isNotEmpty ?? false) {
          for (int i = 0; i < snapshot.data!.docs.length;) {
            return CircleAvatar(
              radius: 64,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  snapshot.data?.docs[i].data()['image'],
                ),
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
