
abstract class GetCommentsStates{}

class InitialState extends GetCommentsStates{}

class SuccessGetCommentsState extends GetCommentsStates{}

class ErrorGetCommentsState extends GetCommentsStates{
  final String error;

  ErrorGetCommentsState(this.error);
}