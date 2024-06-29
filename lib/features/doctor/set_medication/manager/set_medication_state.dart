part of 'set_medication_cubit.dart';

@immutable
abstract class SetMedicationState {}

class SetMedicationInitial extends SetMedicationState {}

class SetMedicationLoadingState extends SetMedicationState{}

class SetMedicationSuccessState extends SetMedicationState{}

class SetMedicationFailureState extends SetMedicationState{

  final String errorMessage;

  SetMedicationFailureState(this.errorMessage);
}
