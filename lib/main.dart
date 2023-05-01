import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/auth_feature/presentation/pages/login_screen.dart';
import 'package:social_application/core/local/cache_helper.dart';
import 'package:social_application/core/styles/themes.dart';
import 'package:social_application/home_feature/manager/delete_post_cubit/delete_post_cubit.dart';
import 'package:social_application/setting_feature/manager/get_user_cubit/get_user_cubit.dart';
import 'package:social_application/social_layout/manager/social_layout_cubit/social_layout_cubit.dart';
import 'package:social_application/social_layout/presentation/pages/social_layout_screen.dart';
import 'core/bloc_observer.dart';
import 'core/utiles/contants.dart';
import 'firebase_options.dart';
import 'home_feature/manager/like_post_cubit/like_post_cubit.dart';
import 'home_feature/manager/post_comment_cubit/post_comment_cubit.dart';
import 'new_post_feature/manager/create_post_cubit/create_post_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});

  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialLayoutCubit()),
        BlocProvider(create: (context) => GetUserCubit()..getUserData()),
        BlocProvider(create: (context) => CreateNewPostCubit()),
        BlocProvider(create: (context) => LikePostCubit(),
        ),
        BlocProvider(create: (context)=>PostCommentCubit()),
        BlocProvider(create: (context)=>DeletePostCubit()),
      ],
      child: MaterialApp(
        title: 'Social Application',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
