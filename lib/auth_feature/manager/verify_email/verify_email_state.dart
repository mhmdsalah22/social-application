abstract class VerifyEmailState{}

class InitialVerifyEmailState extends VerifyEmailState{}

class LoadingVerifyEmailState extends VerifyEmailState{}

class SuccessVerifyEmailState extends VerifyEmailState{}

class ErrorVerifyEmailState extends VerifyEmailState{
  final String error;


  ErrorVerifyEmailState({required this.error});
}
