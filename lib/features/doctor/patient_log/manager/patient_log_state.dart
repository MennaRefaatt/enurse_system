part of 'patient_log_cubit.dart';

@immutable
abstract class PatientLogState {}

class PatientLogInitial extends PatientLogState {}

class PatientLogLoadingState extends PatientLogState{}

class PatientLogSuccessState extends PatientLogState{}

class PatientLogFailureState extends PatientLogState{

  final String errorMessage;

  PatientLogFailureState(this.errorMessage);
}

class GetMedicationsLoadingState extends PatientLogState{}

class GetMedicationsSuccessState extends PatientLogState{}

class GetMedicationsFailureState extends PatientLogState{

  final String errorMessage;

  GetMedicationsFailureState(this.errorMessage);
}