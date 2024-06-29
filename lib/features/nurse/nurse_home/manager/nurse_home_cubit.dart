import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../doctor/doctor_home/model/patient_data_model.dart';
part 'nurse_home_state.dart';

class NurseHomeCubit extends Cubit<NurseHomeState> {
  NurseHomeCubit() : super(NurseHomeInitial());
  final User? user = FirebaseAuth.instance.currentUser;
  String? selectedGenderValue;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController nationalIDController = TextEditingController();
  SingleValueDropDownController genderController =
  SingleValueDropDownController();
  TextEditingController ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool uploading = false;


  List<PatientDataModel> patientDataModel=[];

  getPatients(){
    emit(NurseHomeLoadingState());
    FirebaseFirestore.instance.collection("users")
        .where("type", isEqualTo: "2")
        .snapshots().listen((value)  {
      patientDataModel.clear();
      for(var document in value.docs){
        final patientData = PatientDataModel?.fromMap(document.data());
        patientDataModel.add(patientData);
      }
      safePrint('=============='+"${patientDataModel.length}");
      safePrint(patientDataModel.length);
      emit(NurseHomeSuccessState());
    });
  }

}