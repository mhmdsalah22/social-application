import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_application/auth_feature/manager/register_cubit/register_cubit.dart';
import 'package:social_application/auth_feature/manager/register_cubit/register_state.dart';
import 'package:social_application/auth_feature/presentation/pages/verify_email_page.dart';
import '../../../core/utiles/contants.dart';
import 'login_screen.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var phone = TextEditingController();
  var formKey = GlobalKey<FormState>();
  RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          print('register $state');
          if (state is CreateUserSuccessState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EmailVerificationScreen()));
              Fluttertoast.showToast(
                  msg: 'Success Register',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
          }
          if (state is RegisterErrorState) {
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
          var cubit = RegisterCubit.get(context);
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
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Register now to communication with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
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
                              labelText: 'User Name',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Please Enter Your Email.';
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                          value != null && value.length < 6
                              ? 'Enter min . 6 characters '
                              : null,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  icon:  Icon(cubit.suffix)),
                              border: const OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Number';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                  name: name.text,
                                  email: email.text,
                                  password: password.text,
                                  phone: phone.text);
                            }
                          },
                          decoration: const InputDecoration(
                              labelText: 'Phone',
                              prefixIcon: Icon(Icons.phone_android),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        state is! RegisterLoadingState
                            ? Container(
                                height: 60,
                                width: double.infinity,
                                color: Colors.blue,
                                child: TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userRegister(
                                          name: name.text,
                                          email: email.text,
                                          password: password.text,
                                          phone: phone.text);
                                    }
                                  },
                                  child: const Text(
                                    'REGISTER',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: CircularProgressIndicator()),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'You have account ?',
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
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text(
                                'LOGIN',
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
