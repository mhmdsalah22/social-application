abstract class DeletePostStates{}

class InitialState extends DeletePostStates{}

class SuccessDeletePostState extends DeletePostStates{}

class ErrorDeletePostState extends DeletePostStates{
  final String error;

  ErrorDeletePostState(this.error);
}