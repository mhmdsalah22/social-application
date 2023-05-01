import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_application/auth_feature/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:social_application/auth_feature/manager/reset_password_cubit/reset_password_state.dart';

// ignore: must_be_immutable
class ResetPassword extends StatelessWidget {
  var email = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
        listener: (context, state) {
          if(state is SuccessResetPasswordState){
            Navigator.of(context).popUntil((route) => route.isFirst);
            Fluttertoast.showToast(
                msg: 'Password Reset Email sent.',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }if(state is ErrorResetPasswordState){
            Navigator.of(context).pop();
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
          var cubit = ResetPasswordCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Receive an email to reset your password.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Email';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          cubit.resetPassword(email: email.text);
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      color: Colors.blue,
                      child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.resetPassword(email: email.text);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Reset Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
