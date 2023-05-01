import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/auth_feature/data/data_sources/remote_data_source.dart';
import 'package:social_application/auth_feature/manager/login_cubit/state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void login(String email, String password) {
    emit(LoadingLoginState());

    RemoteDataSource().loginUser(email, password).then((value) {
      emit(SuccessLoginState(uId : value.user!.uid ));
    }).catchError((error) {
      emit(ErrorLoginState(error: error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }
}
