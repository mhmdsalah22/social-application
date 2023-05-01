import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/new_post_feature/manager/create_post_cubit/create_post_states.dart';
import 'package:social_application/setting_feature/manager/get_user_cubit/get_user_states.dart';
import '../../../core/styles/icon_broken.dart';
import '../../../setting_feature/manager/get_user_cubit/get_user_cubit.dart';
import '../../manager/create_post_cubit/create_post_cubit.dart';

// ignore: must_be_immutable
class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetUserCubit()..getUserData(),
      child: BlocBuilder<CreateNewPostCubit, CreateNewPostStates>(
        builder: (context, state) {
          return BlocBuilder<GetUserCubit, GetUserStates>(
            builder: (context, state) {
              if (state is SocialGetUserSuccessState) {
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(IconBroken.Arrow___Left_2)),
                    titleSpacing: 5.0,
                    title: const Text(
                      'Create Post',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          var now = DateTime.now();
                          if (CreateNewPostCubit.get(context).postImage ==
                              null) {
                            CreateNewPostCubit.get(context).createPost(
                                dateTime: now.toString(),
                                text: _textController.text,
                                );
                          } else {
                            CreateNewPostCubit.get(context).uploadPostImage(
                                dateTime: now.toString(),
                                text: _textController.text,
                                name: state.model.name,
                                image: state.model.image);
                          }
                        },
                        child: const Text(
                          'POST',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        if (state is CreatePostLoadingState)
                          const LinearProgressIndicator(),
                        if (state is CreatePostLoadingState)
                          const SizedBox(
                            height: 10,
                          ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                state.model.image,
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: Text(
                                state.model.name,
                                style: const TextStyle(
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _textController,
                            decoration: const InputDecoration(
                              hintText: 'What is on your mind ...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (CreateNewPostCubit.get(context).postImage != null)
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 250,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: FileImage(
                                        CreateNewPostCubit.get(context)
                                            .postImage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  CreateNewPostCubit.get(context)
                                      .removePostImage();
                                },
                                icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      Icons.close,
                                      size: 18,
                                    )),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  CreateNewPostCubit.get(context)
                                      .getPostImage();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      IconBroken.Image,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Add Photo',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  '# Tags',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
