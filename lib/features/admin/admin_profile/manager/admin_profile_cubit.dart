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

part 'admin_profile_state.dart';

class AdminProfileCubit extends Cubit<AdminProfileState> {
  AdminProfileCubit() : super(AdminProfileInitial());
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  String imageUrl = '';
  bool uploading = false;
  TextEditingController adminIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  saveUserData() {
    final data = {
      'name': nameController.text,
      'id': adminIdController.text,
      'email': emailController.text,
    };

    fireStore
        .collection("users")
        .doc(PreferenceUtils.getString(PrefKeys.userId))
        .update(data)
        .then((value) async {
      saveToLocal().then((value) {
        emit(AdminProfileSuccessState());
      });
    });
  }
  Future saveToLocal() async {
    await  PreferenceUtils.setString(PrefKeys.name, nameController.text);
    await  PreferenceUtils.setString(PrefKeys.userId, adminIdController.text);
    await   PreferenceUtils.setString(PrefKeys.email, emailController.text);
  }

  getUserData() {
    fireStore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .get()
        .then((value) {
      PreferenceUtils.setString(PrefKeys.name, value['name']);
      updateUi(value.data()!);
    }).catchError((error) {});
  }

  void updateUi(Map<String, dynamic> data) {
    nameController.text = data['name'];
    emailController.text = data['email'];
    adminIdController.text = data['id'];
    imageUrl = data['imageUrl'];
    emit(AdminProfileSuccessState());
  }

  Future uploadImage(File image) async {
    final userId = auth.currentUser!.uid;
    storage.ref("profileImages/$userId").putFile(image).then((value) {
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

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? file = await picker.pickImage(source: ImageSource.camera);
    File image = File(file!.path);
    await uploadImage(image).then((value) {
      emit(AdminProfileSuccessState());
    });

  }

  void getImageUrl() {
    final userId = auth.currentUser!.uid;
    storage.ref("profileImages/$userId").getDownloadURL().then((value) {
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
    final userId = auth.currentUser!.uid;
    fireStore.collection("users").doc(userId).update({
      'imageUrl': imageUrl,
    });
    await PreferenceUtils.setString(PrefKeys.image, imageUrl).then((value) {
      emit(AdminProfileSuccessState());
    });
  }
}