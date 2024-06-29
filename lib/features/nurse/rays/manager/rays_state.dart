part of 'rays_cubit.dart';

@immutable
abstract class RaysState {}

class RaysInitial extends RaysState {}

class GetRaysLoadingState extends RaysState {}

class GetRaysSuccessState extends RaysState {}

class GetRaysFailureState extends RaysState {
  final String errorMessage;
  GetRaysFailureState(this.errorMessage);
}

class AddRaysLoadingState extends RaysState {}

class AddRaysSuccessState extends RaysState {}

class AddRaysFailureState extends RaysState {
  final String errorMessage;
  AddRaysFailureState(this.errorMessage);
}


class UploadImagesLoadingState extends RaysState {}

class UploadImagesSuccessState extends RaysState {}

class UploadImagesFailureState extends RaysState {
  final String errorMessage;
  UploadImagesFailureState(this.errorMessage);
}

class DeleteRaysLoadingState extends RaysState {}

class DeleteRaysSuccessState extends RaysState {}

class DeleteRaysFailureState extends RaysState {
  final String errorMessage;
  DeleteRaysFailureState(this.errorMessage);
}


