import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/auth_feature/data/data_sources/remote_data_source.dart';
import 'package:social_application/auth_feature/manager/reset_password_cubit/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  ResetPasswordCubit() : super(InitialResetPasswordState());

  static ResetPasswordCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future resetPassword({required String email}) async {
    try {
      await RemoteDataSource().resetPassword(email: email);
      emit(SuccessResetPasswordState());
    } on FirebaseAuthException catch (e) {
      emit(ErrorResetPasswordState(error: e.message.toString()));
    }
  }
}
