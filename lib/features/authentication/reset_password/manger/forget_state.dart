part of 'forget_cubit.dart';

@immutable
abstract class ForgetState {}

class ForgetInitial extends ForgetState {}

class ForgetLoadingState extends ForgetState{}

class ForgetSuccessState extends ForgetState{}

class ForgetFailureState extends ForgetState{

  final String errorMessage;

  ForgetFailureState(this.errorMessage);
}