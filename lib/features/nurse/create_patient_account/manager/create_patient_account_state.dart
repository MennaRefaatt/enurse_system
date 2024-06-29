part of 'create_patient_account_cubit.dart';

@immutable
abstract class CreatePatientAccountState {}

class CreatePatientAccountInitial extends CreatePatientAccountState {}


class CreatePatientAccountLoadingState extends CreatePatientAccountState{}

class CreatePatientAccountSuccessState extends CreatePatientAccountState{}

class CreatePatientAccountFailureState extends CreatePatientAccountState{

  final String errorMessage;
  CreatePatientAccountFailureState(this.errorMessage);
}