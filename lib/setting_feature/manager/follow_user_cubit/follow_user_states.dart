abstract class FollowUserStates{}

class InitialState extends FollowUserStates{}

class SuccessAddFollowUserState extends FollowUserStates{}

class SuccessRemoveFollowUserState extends FollowUserStates{}


class ErrorFollowUserState extends FollowUserStates{
  final String error;

  ErrorFollowUserState(this.error);
}