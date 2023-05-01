import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
     SettingScreen(),
  ];

  List<String> titles = [
    'News Feed',
    'Chats',
    'New Post',
    'Users',
    'Setting',
  ];




  void changeBottomBar(int index) {
    if (index == 2) {
      emit(ChangeBottomState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavigationBarState());
    }
  }
}
