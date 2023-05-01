import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_application/auth_feature/manager/login_cubit/cubit.dart';
import 'package:social_application/auth_feature/manager/login_cubit/state.dart';
import 'package:social_application/auth_feature/presentation/pages/register_screen.dart';
import 'package:social_application/auth_feature/presentation/pages/reset_password.dart';
import 'package:social_application/core/local/cache_helper.dart';
import 'package:social_application/social_layout/presentation/pages/social_layout_screen.dart';
import '../../../core/utiles/contants.dart';

class LoginScreen extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          print('login  $state');
          if (state is SuccessLoginState) {
            CacheHelper.setData(key: 'uId', value: state.uId).then((value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SocialLayout()),
                  (route) => false);
            });
            Fluttertoast.showToast(
                msg: 'Success Login',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is ErrorLoginState) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login now to communication with friends',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.isPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.login(email.text, password.text);
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  icon: Icon(cubit.suffix)),
                              border: const OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        state is LoadingLoginState
                            ? const Center(child: CircularProgressIndicator())
                            : Container(
                                width: double.infinity,
                                color: defaultColor,
                                child: TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.login(email.text, password.text);
                                    }
                                  },
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResetPassword()));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: defaultColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have account ?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                  color: defaultColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
