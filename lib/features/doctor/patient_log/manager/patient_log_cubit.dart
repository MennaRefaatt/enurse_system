import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../model/medications.dart';

part 'patient_log_state.dart';

class PatientLogCubit extends Cubit<PatientLogState> {
  PatientLogCubit() : super(PatientLogInitial());

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  List<MedicationsModel> medicationsModel = [];

  getMedications({required String patientId}) {
    emit(GetMedicationsLoadingState());
    fireStore.collection("set-medications")
        .where('patient_id', isEqualTo:patientId )
        .snapshots().listen((value) {
      medicationsModel.clear();
      for (var document in value.docs) {
        final rays = MedicationsModel.fromMap(document.data());
        medicationsModel.add(rays);
      }
      safePrint(medicationsModel.length);
      emit(GetMedicationsSuccessState());
      Future.delayed(Duration(seconds: 10));
    });
  }
}
