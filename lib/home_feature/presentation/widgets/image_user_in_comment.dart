import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/new_post_feature/manager/user_info_cubit/user_info_cubit.dart';
import 'package:social_application/new_post_feature/manager/user_info_cubit/user_info_states.dart';

class ImageUserInComment extends StatelessWidget {
  const ImageUserInComment({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserInfoCubit, GetUserInfoStates>(
      builder: (context, state) {
      if (state is SuccessGetUserInfoState) {
        return CircleAvatar(
          radius: 18.0,
          backgroundImage:
          NetworkImage(state.model.image),
        );
      }
      return const SizedBox.shrink();
      },
    );
  }
}

