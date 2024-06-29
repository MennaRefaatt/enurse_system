part of 'd_and_n_profile_cubit.dart';

@immutable
abstract class DAndNProfileState {}

class DAndNProfileInitial extends DAndNProfileState {}

class DAndNProfileLoadingState extends DAndNProfileState{}

class DAndNProfileSuccessState extends DAndNProfileState{}
class DAndNProfileUpdateSuccessState extends DAndNProfileState{}

class DAndNProfileFailureState extends DAndNProfileState{

  final String errorMessage;

  DAndNProfileFailureState(this.errorMessage);
}


class DAndNUpdateImageSuccessState extends DAndNProfileState{}
class DAndNUpdateImageFailureState extends DAndNProfileState{}
