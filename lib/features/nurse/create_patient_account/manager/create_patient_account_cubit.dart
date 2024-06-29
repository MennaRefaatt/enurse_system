import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/authentication/register/model/patient_register.dart';
import 'package:enurse_system/shared/my_shared.dart';
import 'package:enurse_system/shared/my_shared_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:enurse_system/features/authentication/register/model/patient_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


part 'create_patient_account_state.dart';

class CreatePatientAccountCubit extends Cubit<CreatePatientAccountState> {
  CreatePatientAccountCubit() : super(CreatePatientAccountInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController SSNController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController entryDateController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController patientProblemController= TextEditingController();

  SingleValueDropDownController genderController =
  SingleValueDropDownController();

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  void createAccount({required String type}) async {
    safePrint("object");
    try {
      final credential = await auth
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        saveUserData(type: "2");
        Fluttertoast.showToast(
            msg: "Patient Added successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black12,
            textColor: Colors.black,
            fontSize: 16.0.sp
        );
      });
      emit(CreatePatientAccountSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(CreatePatientAccountFailureState(
            "The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(CreatePatientAccountFailureState(
            "The account already exists for that email."));
      }
    } catch (e) {
      emit(CreatePatientAccountFailureState(e.toString()));
    }
  }
  void saveUserData({required String type}) {
    FirebaseMessaging.instance.getToken().then((value) async {
      final patientId = auth.currentUser!.uid;
      final patientDoc = fireStore.collection("users").doc(patientId);
      final data = PatientRegisterModel(
          value.toString(),
          nameController.text,
          emailController.text,
          mobileController.text,
          SSNController.text,
          genderController.dropDownValue!.value,
          ageController.text,
          patientId,
          type,
          roomNumberController.text,
          PreferenceUtils.getString(PrefKeys.userId),
          entryDateController.text,
          cityController.text,
      patientProblemController.text
      );
      patientDoc.set(data.toMap());
     await fireStore
          .collection("users")
          .doc(patientId)
          .set(data.toMap())
          .then((value) {
        if (type == "2") {
          final data = PatientMoodel(
              ['_allergies'],
              ['_dailyReport'],
              ['_medicalHistory'],
              ['_notes'],
              '_nurseId',
              ['_rayes'],
              ['_testResults'],
              ['_vitalSigns'],
              '207');
          fireStore.collection("users").doc(patientId).update(data.toMap());
          auth.signOut();
        }
      });
    });
  }





}

