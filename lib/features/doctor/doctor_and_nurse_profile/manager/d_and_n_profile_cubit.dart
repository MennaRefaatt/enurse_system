import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/my_shared.dart';
import '../../../../shared/my_shared_keys.dart';

part 'd_and_n_profile_state.dart';

class DAndNProfileCubit extends Cubit<DAndNProfileState> {
  DAndNProfileCubit() : super(DAndNProfileInitial());

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  String imageUrl = '';
  bool uploading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ssnController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController healthcareInstituteController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  saveUserData() {
    final data = {
      'name': nameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      "age": ageController.text,
      "gender": genderController.text,
      "ssn": ssnController.text,
      "healthcareInstitute": healthcareInstituteController.text,
      "specialization": specializationController.text,
    };
    fireStore
        .collection("users")
        .doc(PreferenceUtils.getString(PrefKeys.userId))
        .update(data)
        .then((value) async {
      saveToLocal().then((value) {

        emit(DAndNProfileUpdateSuccessState());
      });
    });
  }

  Future saveToLocal() async {
    await  PreferenceUtils.setString(PrefKeys.name, nameController.text);
    await  PreferenceUtils.setString(PrefKeys.age, ageController.text);
    await   PreferenceUtils.setString(PrefKeys.specialization, specializationController.text);
    await   PreferenceUtils.setString(PrefKeys.healthcareInstitute, healthcareInstituteController.text);
    await   PreferenceUtils.setString(PrefKeys.phone, phoneController.text);
    await   PreferenceUtils.setString(PrefKeys.gender, genderController.text);

  }

  getUserData() {
    fireStore
        .collection("users")
        .doc(PreferenceUtils.getString(PrefKeys.userId))
        .get()
        .then((value) {
      updateUi(value.data()!);
    }).catchError((error) {});
  }

  void updateUi(Map<String, dynamic> data) {
    nameController.text = data['name'];
    phoneController.text = data['phone'];
    emailController.text = data['email'];
    ssnController.text = data['ssn'];
    ageController.text = data['age'];
    healthcareInstituteController.text = data['healthcareInstitute'];
    specializationController.text = data['specialization'];
    genderController.text = data['gender'];
    imageUrl = data['imageUrl'];
    emit(DAndNProfileSuccessState());
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? file = await picker.pickImage(source: ImageSource.camera);
    File image = File(file!.path);
    await uploadImage(image).then((value) {
      emit(DAndNUpdateImageSuccessState());
    });
  }

  Future uploadImage(File image) async {
    storage
        .ref("profileImages/${PreferenceUtils.getString(PrefKeys.userId)}")
        .putFile(image)
        .then((value) {
      if (kDebugMode) {
        safePrint('uploadImage => SUCCESS');
      }
      getImageUrl();
    }).catchError((error) {
      if (kDebugMode) {
        safePrint('uploadImage => $error');
      }
    });
  }

  void getImageUrl() {
    storage
        .ref("profileImages/${PreferenceUtils.getString(PrefKeys.userId)}")
        .getDownloadURL()
        .then((value) {
      if (kDebugMode) {
        safePrint('getImageUrl => $value');
      }
      saveImageUrl(value);
    }).catchError((error) {
      if (kDebugMode) {
        safePrint('getImageUrl => $error');
      }
    });
  }

  Future<void> saveImageUrl(String imageUrl) async {
    fireStore
        .collection("users")
        .doc(PreferenceUtils.getString(PrefKeys.userId))
        .update({
      'imageUrl': imageUrl,
    });
    await PreferenceUtils.setString(PrefKeys.image, imageUrl).then((value) {
      emit(DAndNUpdateImageSuccessState());
    });
  }
}
