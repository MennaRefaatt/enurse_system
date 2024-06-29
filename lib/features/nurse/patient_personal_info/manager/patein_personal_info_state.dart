part of 'patein_personal_info_cubit.dart';

@immutable
abstract class PatientPersonalInfoState {}

class PatientPersonalInfoInitial extends PatientPersonalInfoState {}

class PatientPersonalInfoSuccess extends PatientPersonalInfoState{}
class PatientPersonalInfoLoadingState extends PatientPersonalInfoState{}

class PatientPersonalInfoFailure extends PatientPersonalInfoState{

  final String errorMessage;
  PatientPersonalInfoFailure(this.errorMessage);
}