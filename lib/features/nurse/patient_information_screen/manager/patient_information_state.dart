
import 'package:flutter/widgets.dart';

@immutable
abstract class PatientInformationState {}

class PatientInformationInitial extends PatientInformationState {}

class PatientInformationLoadingState extends PatientInformationState{}

class PatientInformationSuccessState extends PatientInformationState{}

class PatientInformationFailureState extends PatientInformationState{

  final String errorMessage;
  PatientInformationFailureState(this.errorMessage);
}