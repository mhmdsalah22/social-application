import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_application/setting_feature/manager/get_user_cubit/get_user_cubit.dart';
import 'package:social_application/setting_feature/manager/get_user_cubit/get_user_states.dart';
import 'package:social_application/setting_feature/presentation/widgets/bio.dart';
import 'package:social_application/setting_feature/presentation/widgets/buttons_in_setting_screen.dart';
import 'package:social_application/setting_feature/presentation/widgets/cover_image_for_user.dart';
import 'package:social_application/setting_feature/presentation/widgets/posts.dart';
import '../widgets/general_data_for_the_user_is_page.dart';
import '../widgets/name_in_profile.dart';
import '../widgets/profile_image_for_user.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserCubit, GetUserStates>(
      builder: (context, state) {
        if (state is SocialGetUserSuccessState) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 190,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CoverImageForUser(
                            uId: uid,
                          ),
                          ProfileImageForUser(
                            uId: uid,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    NameInProfile(uId: uid,),
                    Bio(
                      uId: uid,
                    ),
                    GeneralDataForTheUserIsPage(uId: uid),
                    ButtonsInSettingScreen(
                      uId: uid,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Posts(
                      uId: uid,
                    ),
                  ],
                ),
              ),
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
