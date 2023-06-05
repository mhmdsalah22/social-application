import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/auth_feature/presentation/pages/login_screen.dart';
import 'package:social_application/core/styles/icon_broken.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'package:social_application/edit_profile/presentation/pages/edit_profile_screen.dart';
import 'package:social_application/setting_feature/manager/data_profile_cubit/data_profile_cubit.dart';
import 'package:social_application/setting_feature/manager/data_profile_cubit/data_profile_states.dart';
import 'package:social_application/setting_feature/manager/follow_user_cubit/follow_user_cubit.dart';
import 'package:social_application/setting_feature/manager/follow_user_cubit/follow_user_states.dart';
import 'package:social_application/setting_feature/manager/get_user_cubit/get_user_cubit.dart';
import 'package:social_application/setting_feature/manager/get_user_cubit/get_user_states.dart';
import 'package:social_application/setting_feature/presentation/widgets/follow_button.dart';

class ButtonsInSettingScreen extends StatelessWidget {
  const ButtonsInSettingScreen({
    super.key,
    required this.uId,
  });

  final String uId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowUserCubit(),
      child: BlocBuilder<FollowUserCubit, FollowUserStates>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) =>
                DataForProfileCubit()..getFollowersAndFollowing(),
            child: BlocBuilder<DataForProfileCubit, DataForProfileStates>(
              builder: (context, state) {
                return BlocBuilder<GetUserCubit, GetUserStates>(
                  builder: (context, state) {
                    if (state is SocialGetUserSuccessState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          state.model.uId == uId
                              ? Row(
                                  children: [
                                    FollowButton(
                                      text: 'Sign Out',
                                      backgroundColor: defaultColor,
                                      textColor: Colors.white,
                                      borderColor: Colors.grey,
                                      function: () {
                                        FollowUserCubit.get(context).signOut();
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfileScreen()));
                                      },
                                      child: const Icon(
                                        IconBroken.Edit,
                                        size: 16.0,
                                      ),
                                    ),
                                  ],
                                )
                              : DataForProfileCubit.get(context).isFollowing
                                  ? FollowButton(
                                      text: 'Unfollow',
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      borderColor: Colors.grey,
                                      function: () {
                                        FollowUserCubit.get(context).followUser(
                                            followId: state.model.uId);

                                        DataForProfileCubit.get(context)
                                            .removeFollowerButton();
                                      },
                                    )
                                  : FollowButton(
                                      text: 'Follow',
                                      backgroundColor: Colors.blue,
                                      textColor: Colors.white,
                                      borderColor: Colors.blue,
                                      function: () {
                                        FollowUserCubit.get(context).followUser(
                                            followId: state.model.uId);

                                        DataForProfileCubit.get(context)
                                            .addFollowerButton();
                                      },
                                    ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
