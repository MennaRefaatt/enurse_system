part of 'request_state_cubit.dart';

@immutable
abstract class RequestStateState {}

class RequestStateInitial extends RequestStateState {}
class RequestStateSuccess extends RequestStateState {}
class RequestStateFailure extends RequestStateState {}
