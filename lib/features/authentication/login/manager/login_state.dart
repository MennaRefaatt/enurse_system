part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState{}

class LoginSuccessState extends LoginState{
  final String type;
  final String requestState;

  LoginSuccessState(this.type, this.requestState);
}

class LoginFailureState extends LoginState{

  final String errorMessage;
  LoginFailureState(this.errorMessage);
}