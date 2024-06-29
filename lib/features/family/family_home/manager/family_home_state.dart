part of 'family_home_cubit.dart';

@immutable
abstract class FamilyHomeState {}

class FamilyHomeInitial extends FamilyHomeState {}
class FamilyHomeLoadingState extends FamilyHomeState{}

class FamilyHomeSuccessState extends FamilyHomeState{}

class FamilyHomeFailureState extends FamilyHomeState{

  final String errorMessage;
  FamilyHomeFailureState(this.errorMessage);
}