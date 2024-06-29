part of 'ehrscreen_cubit.dart';

@immutable
abstract class EhrscreenState {}

class EhrScreenInitial extends EhrscreenState {}
class EhrscreenLoadingState extends EhrscreenState {}

class EhrscreenSuccessState extends EhrscreenState {}

class EhrscreenFailureState extends EhrscreenState {
  final String errorMessage;
  EhrscreenFailureState(this.errorMessage);
}
