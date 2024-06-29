import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/style/colors/colors.dart';

part 'patein_personal_info_state.dart';

class PateinPersonalInfoCubit extends Cubit<PatientPersonalInfoState> {
  PateinPersonalInfoCubit() : super(PatientPersonalInfoInitial());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController nationalIDController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController1 = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  SingleValueDropDownController genderController2 =
  SingleValueDropDownController();
  Stream? PatientPersonalInfoStream;
  final List<String> Gender = [
    'Male',
    'Female',
  ];
  String? selectedGenderValue;
  final auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future updatePatientInfo(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update(updateInfo);
  }

}
