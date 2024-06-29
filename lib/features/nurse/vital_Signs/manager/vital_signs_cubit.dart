import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'vital_signs_state.dart';

class VitalSignsCubit extends Cubit<VitalSignsState> {
  VitalSignsCubit() : super(VitalSignsInitial());
}
