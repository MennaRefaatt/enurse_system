part of 'patient_home_cubit.dart';

@immutable
abstract class PatientHomeState {}

class PatientHomeInitial extends PatientHomeState {}

class GetPatientHomeLoadingState extends PatientHomeState {}

class GetPatientHomeSuccessState extends PatientHomeState {}

class GetPatientHomeFailureState extends PatientHomeState {
  final String errorMessage;
  GetPatientHomeFailureState(this.errorMessage);
}

class AddPatientHomeLoadingState extends PatientHomeState {}

class AddPatientHomeSuccessState extends PatientHomeState {}

class AddPatientHomeFailureState extends PatientHomeState {
  final String errorMessage;
  AddPatientHomeFailureState(this.errorMessage);
}

