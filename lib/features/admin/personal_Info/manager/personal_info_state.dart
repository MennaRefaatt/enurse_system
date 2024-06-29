part of 'personal_info_cubit.dart';

@immutable
abstract class PersonalInfoState {}

class PersonalInfoInitial extends PersonalInfoState {}

class PersonalInfoSuccess extends PersonalInfoState{}
class PersonalInfoLoadingState extends PersonalInfoState{}

class PersonalInfoFailure extends PersonalInfoState{

  final String errorMessage;
  PersonalInfoFailure(this.errorMessage);
}