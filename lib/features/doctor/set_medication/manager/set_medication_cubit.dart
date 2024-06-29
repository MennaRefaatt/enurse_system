import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../model/set_medication_model.dart';
part 'set_medication_state.dart';

class SetMedicationCubit extends Cubit<SetMedicationState> {
  SetMedicationCubit() : super(SetMedicationInitial());
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  late DateTime startDate;
  late DateTime endDate;
  List<SetMedicationModel> setMedicationModel = [];

  void saveMedication({required String patientId}) {
    safePrint("loading====================>");
    emit(SetMedicationLoadingState());
    SetMedicationModel setMedicationModel = SetMedicationModel(
        nameController.text,
        startDate,
        endDate,
        dosageController.text,
        patientId);
    fireStore
        .collection("set-medications")
        .doc()
        .set(setMedicationModel.toMap())
        .then((value) {
      safePrint("success====================>");
      emit(SetMedicationSuccessState());
      nameController.clear();
      startController.clear();
      endController.clear();
      dosageController.clear();

    }).catchError((e) {
      safePrint("error====================>$e");
      emit(SetMedicationFailureState(e.toString()));
    });
  }
}
