import 'package:flutter/material.dart';
import 'package:social_application/auth_feature/data/models/create_user_model.dart';
import 'package:social_application/core/styles/icon_broken.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({
    Key? key,
    required this.callID,
    required this.model,
  }) : super(key: key);
  final String callID;
  final SocialUserModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ZegoSendCallInvitationButton(
          isVideoCall: true,
          resourceID: "zegouikit_call", // For offline call notification
          invitees: [
            ZegoUIKitUser(
              id: model.uId,
              name: model.name,
            ),

            // ZegoUIKitUser(
            //   id: model.uId,
            //   name: model.name,
            // ),
          ],
        ),
      ),
    );
  }
}
