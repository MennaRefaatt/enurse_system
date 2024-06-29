import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

import '../../../../shared/my_shared.dart';
import '../../../../shared/my_shared_keys.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final auth = FirebaseAuth.instance;
  String type = "";
  void login({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await saveUserData().then((value) {
        safePrint("type  ========> $type");
        FirebaseMessaging.instance.getToken().then((value) {
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          firestore
              .collection("users")
              .doc(auth.currentUser!.uid)
              .update({"deviceToken": value}).then((value) {
            emit(LoginSuccessState(
                type, PreferenceUtils.getString(PrefKeys.requestState)));
          });
        });
      });
    }).catchError((error) {
      safePrint("-----------------------------------------");
      safePrint("$error");
      safePrint("-----------------------------------------");
      if (error is FirebaseAuthException) {
        emit(LoginFailureState("pass or email is wrong"));
      }
    });
  }

  Future saveUserData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid.toString())
        .get()
        .then((value) async {
      safePrint("==================>" + value.get("type"));
      type = value.get("type");
      await PreferenceUtils.setString(PrefKeys.email, value.get("email"));
      await PreferenceUtils.setString(PrefKeys.name, value.get("name"));
      await PreferenceUtils.setString(PrefKeys.type, type);
      await PreferenceUtils.setString(PrefKeys.userId, value.get("id"));
      if (type != "2") {
        await PreferenceUtils.setString(PrefKeys.image, value.get("imageUrl"));
      }
      if (type == "2") {
        PreferenceUtils.setString(PrefKeys.nurseId, value.get("nurseId"));
        PreferenceUtils.setString(PrefKeys.room, value.get("roomNumber"));
      }

      if (type == "0" || type == "1") {
        await PreferenceUtils.setString(
            PrefKeys.requestState, value.get("requestState"));
      }
      if (type != "5") {
        // for admin login to can be done
        await PreferenceUtils.setString(PrefKeys.phone, value.get("phone"));
      }
    });
  }
}
