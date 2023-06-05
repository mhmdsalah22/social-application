import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/setting_feature/manager/data_profile_cubit/data_profile_cubit.dart';
import 'package:social_application/setting_feature/manager/data_profile_cubit/data_profile_states.dart';

class GeneralDataForTheUserIsPage extends StatelessWidget {
  const GeneralDataForTheUserIsPage({
    super.key, required this.uId,
  });
  final String uId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataForProfileCubit()
        ..getPostLength()
        ..getFollowersAndFollowing(),
      child: BlocBuilder<DataForProfileCubit, DataForProfileStates>(
        builder: (context, state) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uId', isEqualTo: uId)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.data?.docs.isNotEmpty ?? false) {
                for (int i = 0; i < snapshot.data!.docs.length;) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${DataForProfileCubit.get(context).postLength}',
                                style:
                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '1',
                                style:
                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${DataForProfileCubit.get(context).followers}',
                                style:
                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${DataForProfileCubit.get(context).following}',
                                style:
                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
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

        },
      ),
    );
  }
}
