abstract class SendMessageStates{}

class InitialState extends SendMessageStates{}

class SuccessSendMessageState extends SendMessageStates{}

class ErrorSendMessageState extends SendMessageStates{
  final String error;

  ErrorSendMessageState(this.error);
}