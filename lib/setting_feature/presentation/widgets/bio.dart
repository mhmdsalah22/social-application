import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Bio extends StatelessWidget {
  const Bio({
    super.key,
    required this.uId,
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
            return Text(
              snapshot.data?.docs[i].data()['bio'],
              style: Theme.of(context).textTheme.bodySmall,
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
