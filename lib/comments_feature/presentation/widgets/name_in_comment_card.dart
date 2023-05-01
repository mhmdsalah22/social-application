import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NameAndTextInCommentCard extends StatelessWidget {
  const NameAndTextInCommentCard({
    super.key,
    required this.snap,
  });

  final snap;

  @override
  Widget build(BuildContext context) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uId', isEqualTo: snap['uId'])
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                for (int i = 0; i < snapshot.data!.docs.length;) {
                  return RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: snapshot.data?.docs[i].data()['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: ' ${snap['text'].toString()}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
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
