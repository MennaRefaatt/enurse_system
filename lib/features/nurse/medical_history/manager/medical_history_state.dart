part of 'medical_history_cubit.dart';

@immutable
abstract class MedicalHistoryState {}

class MedicalHistoryInitial extends MedicalHistoryState {}

class GetMedicalHistoryLoadingState extends MedicalHistoryState {}

class GetMedicalHistorySuccessState extends MedicalHistoryState {}

class GetMedicalHistoryFailureState extends MedicalHistoryState {
  final String errorMessage;
  GetMedicalHistoryFailureState(this.errorMessage);
}

class AddMedicalHistoryLoadingState extends MedicalHistoryState {}

class AddMedicalHistorySuccessState extends MedicalHistoryState {}

class AddMedicalHistoryFailureState extends MedicalHistoryState {
  final String errorMessage;
  AddMedicalHistoryFailureState(this.errorMessage);
}

class GetMedicationNamesLoadingState extends MedicalHistoryState {}

class GetMedicationNamesSuccessState extends MedicalHistoryState {}