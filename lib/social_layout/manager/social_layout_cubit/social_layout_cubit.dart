import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/chats_feature/manager/get_all_users_cubit/get_all_users_cubit.dart';
import 'package:social_application/chats_feature/presentation/pages/chats_screen.dart';
import 'package:social_application/home_feature/presentation/pages/home_screen.dart';
import 'package:social_application/new_post_feature/presentation/pages/new_post_screen.dart';
import 'package:social_application/setting_feature/presentation/pages/setting_screen.dart';
import 'package:social_application/social_layout/manager/social_layout_cubit/social_layout_states.dart';
import 'package:social_application/users_feature/presentation/pages/users_screen.dart';

class SocialLayoutCubit extends Cubit<SocialLayoutStates> {
  SocialLayoutCubit() : super(InitialState());

  static SocialLayoutCubit get(BuildContext context) =>
      BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const UsersScreen(),
    SettingScreen(uid: FirebaseAuth.instance.currentUser?.uid??'sew1lCAVSmOPCDZ7ZRC2EIrPm812',),
  ];

  List<String> titles = [
    'News Feed',
    'Chats',
    'New Post',
    'Users',
    'Profile',
  ];

  void changeBottomBar(int index, BuildContext context) {
    if (index == 1) {
      GetAllUsersCubit.get(context).getAllUsers();
    }
    if (index == 2) {
      emit(ChangeBottomState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavigationBarState());
    }
  }
}
