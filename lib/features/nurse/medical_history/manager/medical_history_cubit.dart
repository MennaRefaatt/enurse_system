import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/nurse/medical_history/model/medical_history_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../doctor/patient_log/model/medications.dart';

part 'medical_history_state.dart';

class MedicalHistoryCubit extends Cubit<MedicalHistoryState> {
  MedicalHistoryCubit() : super(MedicalHistoryInitial());
  TextEditingController diseaseController = TextEditingController();
  TextEditingController dateOfIllnessController = TextEditingController();
  TextEditingController treatedOrNotController = TextEditingController();
  TextEditingController medicationsController = TextEditingController();
  List<MedicalHistoryModel> medicalHistoryModel = [];
  final fireStore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  String date = "";
  final firestore = FirebaseFirestore.instance;

  getMedicalHistory({required String patientId}) {
    emit(GetMedicalHistoryLoadingState());
    fireStore.collection("medicalHistory")
        .where("patientId", isEqualTo: patientId)
        .snapshots()
        .listen((value) {
      medicalHistoryModel.clear();
      for (var document in value.docs) {
        final medicalHistory = MedicalHistoryModel.fromMap(document.data());
        medicalHistoryModel.add(medicalHistory);
      }
      safePrint(medicalHistoryModel.length);
      emit(GetMedicalHistorySuccessState());
    });
  }

  void saveMedicalHistoryData(
      {required String patientId, required String patientName}) {
    emit(AddMedicalHistoryLoadingState());
    MedicalHistoryModel medicalHistoryModel = MedicalHistoryModel(
        dateOfIllness: date,
        disease: diseaseController.text,
        medication: medicationsController.text,
        treatedOrNOt: treatedOrNotController.text,
        patientId: patientId,
        patientName: patientName);
    fireStore
        .collection("medicalHistory")
        .doc()
        .set(medicalHistoryModel.toMap())
        .then((value) {
      getMedicalHistory(patientId: patientId);
      Fluttertoast.showToast(
          msg: "Medical History Added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black12,
          textColor: Colors.black,
          fontSize: 16.0.sp);

      emit(AddMedicalHistorySuccessState());
    }).catchError((e) {
      emit(AddMedicalHistoryFailureState(e.toString()));
    });
  }

}
