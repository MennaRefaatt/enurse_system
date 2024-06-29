part of 'user_type_cubit.dart';

@immutable
abstract class UserTypeState {}

class UserTypeInitial extends UserTypeState {}
class UserTypeLoading extends UserTypeState {}
class UserTypeSuccess extends UserTypeState {}

class UserTypeFailure extends UserTypeState {
  final String errorMessage;

  UserTypeFailure(this.errorMessage);
}
