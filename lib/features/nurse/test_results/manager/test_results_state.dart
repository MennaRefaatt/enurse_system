part of 'test_results_cubit.dart';

@immutable
abstract class TestResultsState {}

class TestResultsInitial extends TestResultsState {}

class GetTestResultsLoadingState extends TestResultsState {}

class GetTestResultsSuccessState extends TestResultsState {}

class GetTestResultsFailureState extends TestResultsState {
  final String errorMessage;
  GetTestResultsFailureState(this.errorMessage);
}

class AddTestResultsLoadingState extends TestResultsState {}

class AddTestResultsSuccessState extends TestResultsState {}

class AddTestResultsFailureState extends TestResultsState {
  final String errorMessage;
  AddTestResultsFailureState(this.errorMessage);
}


class UploadImagesLoadingState extends TestResultsState {}

class UploadImagesSuccessState extends TestResultsState {}

class UploadImagesFailureState extends TestResultsState {
  final String errorMessage;
  UploadImagesFailureState(this.errorMessage);
}

class DeleteTestResultsLoadingState extends TestResultsState {}

class DeleteTestResultsSuccessState extends TestResultsState {}

class DeleteTestResultsFailureState extends TestResultsState {
  final String errorMessage;
  DeleteTestResultsFailureState(this.errorMessage);
}




