import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/shared/my_shared.dart';
import 'package:enurse_system/shared/my_shared_keys.dart';
import 'package:meta/meta.dart';

part 'request_state_state.dart';

class RequestStateCubit extends Cubit<RequestStateState> {
  RequestStateCubit() : super(RequestStateInitial());
  FirebaseFirestore firestore = FirebaseFirestore.instance;
String requestState = "";
String type = "";
  checkRequestState(){
    safePrint("===================>${PreferenceUtils.getString(PrefKeys.userId)}");
    firestore.collection("users")
        .doc(PreferenceUtils.getString(PrefKeys.userId)).snapshots().listen((value) {
      requestState = value['requestState'];
      type = value['type'];
      safePrint("=========================================>"+requestState);
      emit(RequestStateSuccess());
    });
  }






}
