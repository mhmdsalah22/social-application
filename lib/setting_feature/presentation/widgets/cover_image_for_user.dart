import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class CoverImageForUser extends StatelessWidget {
  const CoverImageForUser({
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
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        snapshot.data?.docs[i].data()['cover']
                    ),
                    fit: BoxFit.cover,
                  ),
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
