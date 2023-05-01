abstract class LoginState{}

class InitialLoginState extends LoginState{}

class LoadingLoginState extends LoginState{}

class SuccessLoginState extends LoginState
{
  final String uId;

  SuccessLoginState({required this.uId});
}

class ErrorLoginState extends LoginState{
  final String error;
  

  ErrorLoginState({required this.error});
}

class RegisterChangePasswordVisibilityState extends LoginState {}