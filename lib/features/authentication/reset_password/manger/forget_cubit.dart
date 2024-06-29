import 'package:bloc/bloc.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
part 'forget_state.dart';

class ForgetCubit extends Cubit<ForgetState> {
  ForgetCubit() : super(ForgetInitial());
  void resetPassword(String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
        emit(ForgetSuccessState());
      } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        safePrint(e);
      }
      emit(ForgetFailureState(e.message.toString()));
    }
  }
}
