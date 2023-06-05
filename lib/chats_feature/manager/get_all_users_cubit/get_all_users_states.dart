import 'package:social_application/auth_feature/data/models/create_user_model.dart';

abstract class GetAllUsersStates{}

class InitialState extends GetAllUsersStates{}

class LoadingGetAllUsersState extends GetAllUsersStates{}

class SuccessGetAllUsersState extends GetAllUsersStates{}

class ErrorGetAllUsersState extends GetAllUsersStates{
  final String error;

  ErrorGetAllUsersState(this.error);
}