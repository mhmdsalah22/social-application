import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/core/styles/icon_broken.dart';
import 'package:social_application/new_post_feature/presentation/pages/new_post_screen.dart';
import 'package:social_application/search_feature/presentation/pages/search_screen.dart';
import 'package:social_application/social_layout/manager/social_layout_cubit/social_layout_cubit.dart';
import 'package:social_application/social_layout/manager/social_layout_cubit/social_layout_states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {
        if (state is ChangeBottomState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewPostScreen()));
        }
      },
      builder: (context, state) {
        var cubit = SocialLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconBroken.Notification,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                icon: const Icon(
                  IconBroken.Search,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Setting'),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeBottomBar(index, context);
            },
          ),
        );
      },
    );
  }
}
