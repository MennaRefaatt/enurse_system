part of 'admin_profile_cubit.dart';

@immutable
abstract class AdminProfileState {}

class AdminProfileInitial extends AdminProfileState {}
class AdminProfileLoadingState extends AdminProfileState{}

class AdminProfileSuccessState extends AdminProfileState{}
class AdminProfileUpdateSuccessState extends AdminProfileState{}

class AdminProfileFailureState extends AdminProfileState{

  final String errorMessage;

  AdminProfileFailureState(this.errorMessage);
}


class AdminProfileUpdateImageSuccessState extends AdminProfileState{}
class AdminProfileUpdateImageFailureState extends AdminProfileState{}
