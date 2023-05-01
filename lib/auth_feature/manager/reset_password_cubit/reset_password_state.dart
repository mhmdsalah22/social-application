abstract class ResetPasswordStates{}

class InitialResetPasswordState extends ResetPasswordStates{}

class LoadingResetPasswordState extends ResetPasswordStates{}

class SuccessResetPasswordState extends ResetPasswordStates{}

class ErrorResetPasswordState extends ResetPasswordStates{
  final String error;


  ErrorResetPasswordState({required this.error});
}
