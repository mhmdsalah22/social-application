import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/auth_feature/data/models/create_user_model.dart';
import 'package:social_application/auth_feature/presentation/pages/login_screen.dart';
import 'package:social_application/chats_details_feature/manager/get_message_cubit/get_message_cubit.dart';
import 'package:social_application/chats_feature/manager/get_all_users_cubit/get_all_users_cubit.dart';
import 'package:social_application/core/local/cache_helper.dart';
import 'package:social_application/core/styles/themes.dart';
import 'package:social_application/home_feature/manager/delete_post_cubit/delete_post_cubit.dart';
import 'package:social_application/setting_feature/manager/get_user_cubit/get_user_cubit.dart';
import 'package:social_application/social_layout/manager/social_layout_cubit/social_layout_cubit.dart';
import 'package:social_application/social_layout/presentation/pages/social_layout_screen.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'chats_details_feature/manager/send_message_cubit/send_message_cubit.dart';
import 'core/bloc_observer.dart';
import 'core/utiles/contants.dart';
import 'firebase_options.dart';
import 'home_feature/manager/like_post_cubit/like_post_cubit.dart';
import 'home_feature/manager/post_comment_cubit/post_comment_cubit.dart';
import 'new_post_feature/manager/create_post_cubit/create_post_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final navigatorKey = GlobalKey<NavigatorState>();
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = const SocialLayout();
    onUserLogin();
  } else {
    widget = LoginScreen();
  }
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
  });
  runApp(MyApp(
    startWidget: widget,
    navigatorKey: navigatorKey,
  ));
}

SocialUserModel? model;

void onUserLogin() {
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: 440884364 /*input your AppID*/,
    appSign: "8e0b43e9d132da7c8bf2498b1e1ffcfb91d7681a2a86b8a22ee5a45038aab4a9",
    /*input your AppSign*/
    userID: uId!,
    userName: model?.name ?? 'Mohammed Salah',
    plugins: [ZegoUIKitSignalingPlugin()],
  );
}

void onUserLogout() {
  /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
  /// when app's user is logged out
  ZegoUIKitPrebuiltCallInvitationService().uninit();
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key, required this.startWidget, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialLayoutCubit()),
        BlocProvider(create: (context) => GetUserCubit()..getUserData()),
        BlocProvider(create: (context) => CreateNewPostCubit()),
        BlocProvider(
          create: (context) => LikePostCubit(),
        ),
        BlocProvider(create: (context) => PostCommentCubit()),
        BlocProvider(create: (context) => DeletePostCubit()),
        BlocProvider(create: (context) => GetAllUsersCubit()..getAllUsers()),
        BlocProvider(create: (context) => GetMessageCubit()),
        BlocProvider(create: (context) => SendMessageCubit()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Social Application',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
