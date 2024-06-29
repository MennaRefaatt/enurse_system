import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit() : super(PersonalInfoInitial());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController healthcareInstituteController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController ssnController = TextEditingController();
  TextEditingController ageController = TextEditingController();

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
