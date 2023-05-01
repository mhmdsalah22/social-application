import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_application/core/styles/icon_broken.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'package:social_application/edit_profile/presentation/pages/edit_profile_screen.dart';
import 'package:social_application/setting_feature/manager/get_user_cubit/get_user_cubit.dart';
import 'package:social_application/setting_feature/manager/get_user_cubit/get_user_states.dart';

class SettingScreen extends StatelessWidget {
   SettingScreen({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserCubit, GetUserStates>(
      builder: (context, state) {
        if (state is SocialGetUserSuccessState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
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
                                state.model.cover,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              state.model.image
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  state.model.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  state.model.bio,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Add Photos',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: defaultColor, fontSize: 18),
                      ),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfileScreen()));
                      },
                      child: const Icon(IconBroken.Edit),
                    )
                  ],
                ),
              ],
            ),
          );
        } else if (state is SocialGetUserLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SocialGetUserErrorState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
