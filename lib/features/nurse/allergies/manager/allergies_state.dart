part of 'allergies_cubit.dart';

@immutable
abstract class AllergiesState {}

class AllergiesInitial extends AllergiesState {

}


class GetAllergiesLoadingState extends AllergiesState{}

class GetAllergiesSuccessState extends AllergiesState{}

class GetAllergiesFailureState extends AllergiesState{

  final String errorMessage;
  GetAllergiesFailureState(this.errorMessage);
}
class AddAllergiesLoadingState extends AllergiesState {}

class AddAllergiesSuccessState extends AllergiesState {}

class AddAllergiesFailureState extends AllergiesState {
  final String errorMessage;
  AddAllergiesFailureState(this.errorMessage);
}