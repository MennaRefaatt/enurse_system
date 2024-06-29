part of 'doctor_patient_view_cubit.dart';

@immutable
abstract class DoctorPatientViewState {}

class DoctorPatientViewInitial extends DoctorPatientViewState {}

class DoctorPatientViewLoadingState extends DoctorPatientViewState{}

class DoctorPatientViewSuccessState extends DoctorPatientViewState{}

class DoctorPatientViewFailureState extends DoctorPatientViewState{

  final String errorMessage;

  DoctorPatientViewFailureState(this.errorMessage);
}
