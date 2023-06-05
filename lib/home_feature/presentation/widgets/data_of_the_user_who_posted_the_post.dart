
import 'package:flutter/material.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'package:social_application/home_feature/presentation/widgets/build_post_item.dart';
import 'package:social_application/home_feature/presentation/widgets/delete_post.dart';
import 'package:social_application/home_feature/presentation/widgets/image_user_in_post.dart';
import 'package:social_application/home_feature/presentation/widgets/username_for_post.dart';
import 'package:social_application/new_post_feature/manager/create_post_cubit/create_post_states.dart';
import 'package:social_application/setting_feature/presentation/pages/setting_screen.dart';

class DataOfTheUserWhoPostedThePost extends StatelessWidget {
  const DataOfTheUserWhoPostedThePost({
    super.key,
    required this.widget,
    required this.state,required this.snap,
  });
  final snap;
  final BuildPostItem widget;
  final GetPostSuccessState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingScreen(
                  uid: snap['uId'],
                ),
              ),
            );
          },
          child: ImageUserInPost(
            widget: widget,
            model: state.model,
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  UserNameForPost(
                    widget: widget,
                    model: state.model,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: defaultColor,
                    size: 16.0,
                  ),
                ],
              ),
              // dateTimeForPost(context),
            ],
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
        DeletePost(
          snap: widget.snap,
        ),
      ],
    );
  }
}
