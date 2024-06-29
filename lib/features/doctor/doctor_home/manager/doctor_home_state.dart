part of 'doctor_home_cubit.dart';

@immutable
abstract class DoctorHomeState {}

class DoctorHomeInitial extends DoctorHomeState {}

class DoctorHomeLoadingState extends DoctorHomeState {}

class DoctorHomeSuccessState extends DoctorHomeState {}

class DoctorHomeFailureState extends DoctorHomeState {
  final String errorMessage;
  DoctorHomeFailureState(this.errorMessage);
}
