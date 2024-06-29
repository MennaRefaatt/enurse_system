part of 'nurse_home_cubit.dart';

@immutable
sealed class NurseHomeState {}

final class NurseHomeInitial extends NurseHomeState {}
class CreatePatientAccountInitial extends NurseHomeState {}


class NurseHomeLoadingState extends NurseHomeState{}

class NurseHomeSuccessState extends NurseHomeState{}

class NurseHomeFailureState extends NurseHomeState{

  final String errorMessage;
  NurseHomeFailureState(this.errorMessage);
}