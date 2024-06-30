
import 'package:flutter/widgets.dart';

import '../../../doctor/doctor_patient_view/model/daily_report_model.dart';

@immutable
abstract class PatientInformationState {}

class PatientInformationInitial extends PatientInformationState {}

class PatientInformationLoadingState extends PatientInformationState{}

class PatientInformationSuccessState extends PatientInformationState{}

class PatientInformationFailureState extends PatientInformationState{

  final String errorMessage;
  PatientInformationFailureState(this.errorMessage);
}

class DailyReportLoadingState extends PatientInformationState{}

class DailyReportSuccessState extends PatientInformationState{}

class DailyReportFailureState extends PatientInformationState{
  final List<DailyReportModel> dailyReport;

   DailyReportFailureState(this.dailyReport);

  @override
  List<Object> get props => [dailyReport];
}