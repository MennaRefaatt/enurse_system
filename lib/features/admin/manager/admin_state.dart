part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminNurseLoadingState extends AdminState {}

class AdminNurseSuccessState extends AdminState {}

class AdminNurseFailureState extends AdminState {
  final String errorMessage;
  AdminNurseFailureState(this.errorMessage);
}
class AdminDoctorLoadingState extends AdminState {}

class AdminDoctorSuccessState extends AdminState {}

class AdminDoctorFailureState extends AdminState {
  final String errorMessage;
  AdminDoctorFailureState(this.errorMessage);
}


class UpdateRequestStateLoading extends AdminState{

}

class UpdateRequestStateSuccess extends AdminState{

}

class UpdateRequestStateFailure extends AdminState{
  final String message;

  UpdateRequestStateFailure(this.message);
}


class GetRequestStateLoading extends AdminState{

}
class GetRequestStateSuccess extends AdminState{

}
class GetRequestStateFailure extends AdminState{
  final String message;

  GetRequestStateFailure(this.message);
}



