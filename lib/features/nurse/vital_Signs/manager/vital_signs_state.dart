part of 'vital_signs_cubit.dart';

@immutable
abstract class VitalSignsState {}

class VitalSignsInitial extends VitalSignsState {}


class VitalSignsLoadingState extends VitalSignsState{}

class VitalSignsSuccessState extends VitalSignsState{}

class VitalSignsFailureState extends VitalSignsState{

  final String errorMessage;
  VitalSignsFailureState(this.errorMessage);
}