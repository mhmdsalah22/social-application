abstract class LikePostStates{}

class InitialState extends LikePostStates{}

class SuccessGetLikeState extends LikePostStates{}


class SuccessAddLikeState extends LikePostStates{}

class SuccessRemoveLikeState extends LikePostStates{}


class ErrorLikeState extends LikePostStates {
  final String error;
  ErrorLikeState(this.error);
}

