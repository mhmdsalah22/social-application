abstract class DataForProfileStates {}

class InitialState extends DataForProfileStates {}

class SuccessGetLengthPostState extends DataForProfileStates {}

class ErrorGetLengthPostState extends DataForProfileStates {
  final String error;

  ErrorGetLengthPostState(this.error);
}

class SuccessGetDataForProfileState extends DataForProfileStates {}

class ErrorGetDataForProfileState extends DataForProfileStates {
  final String error;

  ErrorGetDataForProfileState(this.error);
}

class SuccessAddFollowState extends DataForProfileStates {}

class ErrorAddFollowState extends DataForProfileStates {
  final String error;

  ErrorAddFollowState(this.error);
}

class SuccessRemoveFollowState extends DataForProfileStates {}

class ErrorRemoveFollowState extends DataForProfileStates {
  final String error;

  ErrorRemoveFollowState(this.error);
}