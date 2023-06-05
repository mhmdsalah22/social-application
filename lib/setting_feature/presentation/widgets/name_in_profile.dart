import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/setting_feature/manager/data_profile_cubit/data_profile_cubit.dart';
import 'package:social_application/setting_feature/manager/data_profile_cubit/data_profile_states.dart';

class NameInProfile extends StatelessWidget {
  const NameInProfile({
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
              snapshot.data?.docs[i].data()['name'] ?? 'Mohammed',
              style: Theme.of(context).textTheme.bodyMedium,
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
