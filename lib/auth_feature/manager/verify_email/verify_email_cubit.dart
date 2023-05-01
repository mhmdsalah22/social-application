import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/auth_feature/data/data_sources/remote_data_source.dart';
import 'package:social_application/auth_feature/manager/verify_email/verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit() : super(InitialVerifyEmailState());

  static VerifyEmailCubit get(BuildContext context) => BlocProvider.of(context);

  Future verifyEmail() async {
    try {
      emit(LoadingVerifyEmailState());
      await RemoteDataSource().sendEmailVerification().then((value) {
        if (RemoteDataSource().isEmailVerified) {
          emit(SuccessVerifyEmailState());
        }
      });
    } on FirebaseAuthException catch (e) {
      emit(ErrorVerifyEmailState(error: e.message.toString()));
    }
  }
}
