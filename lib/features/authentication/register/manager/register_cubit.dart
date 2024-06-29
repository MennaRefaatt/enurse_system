import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/authentication/register/model/doctor_model.dart';
import 'package:enurse_system/features/authentication/register/model/family_model.dart';
import 'package:enurse_system/features/authentication/register/model/register_model.dart';
import 'package:enurse_system/features/authentication/register/requestState.dart';
import 'package:enurse_system/shared/my_shared.dart';
import 'package:enurse_system/shared/my_shared_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ssnController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController healthcareInstituteController = TextEditingController();
  TextEditingController patientIdController = TextEditingController();
  TextEditingController kinShipController = TextEditingController();
  SingleValueDropDownController genderController =
      SingleValueDropDownController();

  Future createAccount({required String type}) async {
    emit(RegisterLoadingState());
    safePrint("object");
    try {
    await auth
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      ).then((value) async {
        await saveUserData(type: type).then((value) {
          safePrint("object");
        });
        await saveDataToLocal(
          email: emailController.text,
          name: nameController.text,
          type: type,
          userId: auth.currentUser!.uid,
          image: "",
          phone: phoneController.text,
          requestState: RequestState.pending.name,

          ssn: ssnController.text,
          gender: genderController.dropDownValue!.value,
          age: ageController.text,
          specialization: specializationController.text,
          healthcareInstitute: healthcareInstituteController.text,
          kinShip: kinShipController.text,
          patientId: patientIdController.text,
        ).then((value) {
          emit(RegisterSuccessState());
        });

      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailureState("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(
            RegisterFailureState("The account already exists for that email."));
      }
    } catch (e) {
      emit(RegisterFailureState(e.toString()));
    }
  }

  Future saveUserData({required String type}) async {
    safePrint(type);
    FirebaseMessaging.instance.getToken().then((value) async {
      final userId = auth.currentUser!.uid;
      final data = RegisterModel(
        value.toString(),
        nameController.text,
        emailController.text,
        phoneController.text,
        ssnController.text,
        genderController.dropDownValue!.value,
        ageController.text,
        userId,
        type,
        RequestState.pending.name,
        "",
      );
      await fireStore
          .collection("users")
          .doc(userId)
          .set(data.toMap())
          .then((value) async {
        if (type == "0" || type == "1") {
          final data = DoctorAndNurseModel(
            specialization: specializationController.text,
            healthcareInstitute: healthcareInstituteController.text,
          );

        safePrint( "===========>"+specializationController.text);
        safePrint( "===========>"+healthcareInstituteController.text);
          fireStore
              .collection("users")
              .doc(userId)
              .update(data.toMap())
              .then((value) => safePrint('===>success'))
              .catchError((error) => safePrint("===>fail" + error.toString()));
        }
        if (type == "3") {
          final data = FamilyModel(
              kinShip: kinShipController.text,
              patientId: patientIdController.text);
          fireStore.collection("users").doc(userId).update(data.toMap());
        }
      });

    });
  }

  Future<void> saveDataToLocal(
      {required String email,
      required String name,
      required String ssn,
      required String type,
      required String userId,
      required String image,
      required String phone,
      required String requestState,
      required String gender,
      required String age,
      required String specialization,
      required String healthcareInstitute,
      required String kinShip,
      required String patientId}) async {
    await PreferenceUtils.setString(PrefKeys.email, email);
    await PreferenceUtils.setString(PrefKeys.ssn, ssn);
    await PreferenceUtils.setString(PrefKeys.name, name);
    await PreferenceUtils.setString(PrefKeys.type, type);
    await PreferenceUtils.setString(PrefKeys.userId, userId);
    await PreferenceUtils.setString(PrefKeys.image, image);
    await PreferenceUtils.setString(PrefKeys.phone, phone);
    await PreferenceUtils.setString(PrefKeys.requestState, requestState);
    await PreferenceUtils.setString(PrefKeys.age, age);
    await PreferenceUtils.setString(PrefKeys.gender, gender);
    if (type == "0" || type == "1") {
      await PreferenceUtils.setString(PrefKeys.specialization, specialization);
      await PreferenceUtils.setString(
          PrefKeys.healthcareInstitute, healthcareInstitute);
    }
    if (type == "3") {
      await PreferenceUtils.setString(PrefKeys.kinShipController, kinShip);
      await PreferenceUtils.setString(PrefKeys.patientIdController, patientId);
    }
  }
}
