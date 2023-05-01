import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/core/styles/icon_broken.dart';
import 'package:social_application/core/utiles/contants.dart';
import 'package:social_application/setting_feature/manager/get_user_cubit/get_user_cubit.dart';
import 'package:social_application/setting_feature/manager/get_user_cubit/get_user_states.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserCubit, GetUserStates>(
      builder: (context, state) {
        var profileImage = GetUserCubit.get(context).profileImage;
        var coverImage = GetUserCubit.get(context).coverImage;
        if (state is SocialGetUserSuccessState) {
          email.text = state.model.email;
          name.text = state.model.name;
          bio.text = state.model.bio;
          phone.text = state.model.phone;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(IconBroken.Arrow___Left_2)),
              titleSpacing: 5.0,
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    GetUserCubit.get(context).updateUser(
                      name: name.text,
                      email: email.text,
                      phone: phone.text,
                      bio: bio.text,
                    );
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: defaultColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is UserUpdateLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 190,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                    image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage(
                                              state.model.cover,
                                            )
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    GetUserCubit.get(context).getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                      radius: 20,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 18,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(state.model.image)
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  GetUserCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 18,
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (GetUserCubit.get(context).profileImage != null ||
                        GetUserCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (GetUserCubit.get(context).coverImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                Container(
                                  color: Colors.blue,
                                  child: TextButton(
                                    onPressed: () {
                                      GetUserCubit.get(context)
                                          .uploadCoverImage(
                                        name: name.text,
                                        email: email.text,
                                        phone: phone.text,
                                        bio: bio.text,
                                      );
                                    },
                                    child: const Text(
                                      'Upload Cover',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                if (state is UserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            )),
                          if (GetUserCubit.get(context).profileImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                Container(
                                  color: Colors.blue,
                                  child: TextButton(
                                    onPressed: () {
                                      GetUserCubit.get(context)
                                          .uploadProfileImage(
                                        name: name.text,
                                        email: email.text,
                                        phone: phone.text,
                                        bio: bio.text,
                                      );
                                    },
                                    child: const Text(
                                      'Upload Profile',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                if (state is UserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            )),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    if (GetUserCubit.get(context).profileImage != null ||
                        GetUserCubit.get(context).coverImage != null)
                      const SizedBox(
                        height: 20,
                      ),
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(IconBroken.User),
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: bio,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your bio';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(IconBroken.Info_Circle),
                        labelText: 'Bio',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(IconBroken.Call),
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is SocialGetUserLoadingState) {
          return Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
