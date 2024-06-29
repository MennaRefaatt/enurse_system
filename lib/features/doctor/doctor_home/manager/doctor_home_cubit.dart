import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/doctor/doctor_home/model/patient_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
part 'doctor_home_state.dart';

class DoctorHomeCubit extends Cubit<DoctorHomeState> {
  DoctorHomeCubit() : super(DoctorHomeInitial());

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  String imageUrl = '';

  List<PatientDataModel> patientDataModel=[];

  getPatients(){
    emit(DoctorHomeLoadingState());
    fireStore.collection("users")
        .where("type", isEqualTo: "2")
        .snapshots().listen((value)  {
      patientDataModel.clear();
      for(var document in value.docs){
        final patientData = PatientDataModel.fromMap(document.data());
        patientDataModel.add(patientData);
      }
      safePrint('patientDataModelLength============== '+"${patientDataModel.length}");
      emit(DoctorHomeSuccessState());
    });
  }


}
