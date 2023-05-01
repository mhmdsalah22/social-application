import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/auth_feature/data/data_sources/remote_data_source.dart';
import 'package:social_application/auth_feature/manager/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());

    RemoteDataSource().registerUser(
        name: name, email: email, password: password, phone: phone).then((value)
    {
      createUser(name: name, email: email, phone: phone, uId: value.user!.uid);
    }).catchError((error)
    {
      emit(RegisterErrorState(error.toString()));
    });
  }


  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,

  })
  {
    RemoteDataSource().createUser(name: name, email: email, phone: phone, uId: uId).then((value)
    {
      emit(CreateUserSuccessState());
    }).catchError((error)
    {
      emit(CreateUserErrorState(error.toString()));
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
