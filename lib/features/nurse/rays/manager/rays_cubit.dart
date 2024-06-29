import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/rays_model.dart';
part 'rays_state.dart';

class RaysCubit extends Cubit<RaysState> {
  RaysCubit() : super(RaysInitial());
  final picker = ImagePicker();
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  List<RaysModel> raysModel = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String date = "";
  String documentId = '';
  List<String> imagesList = [];
  final List<XFile> files = [];

  getRays({required String patientId}) {
    emit(GetRaysLoadingState());
    fireStore
        .collection("rays")
        .where('patientId', isEqualTo: patientId)
        .snapshots()
        .listen((value) {
      raysModel.clear();
      for (var document in value.docs) {
        final rays = RaysModel.fromMap(document.data());
        raysModel.add(rays);
      }
      safePrint(raysModel.length);
      emit(GetRaysSuccessState());
    });
  }
  Future<void> deleteRays(RaysModel raysModel) async {
    emit(DeleteRaysLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection("rays")
          .doc(raysModel.documentId)
          .delete();
      emit(DeleteRaysSuccessState());
    } catch (e) {
      emit(DeleteRaysFailureState(e.toString()));
    }
  }


  saveRayData({required String patientId}) {
    emit(AddRaysLoadingState());
    DateTime dateTime = DateTime.now();
    RaysModel raysModel = RaysModel(
      title: nameController.text,
      date: date,
      images: imagesList,
      patientId: patientId,
      documentId: dateTime.toString(),
    );

    uploadImages(files).then((value) {
      fireStore
          .collection("rays")
          .doc(dateTime.toString())
          .set(raysModel.toMap())
          .then((value) async {
        emit(AddRaysSuccessState());
        nameController.clear();
        dateController.clear();
        imagesList.clear();
        files.clear();
      }).catchError((e) {
        emit(AddRaysFailureState(e.toString()));
      });
    });
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final List<XFile> imagesListFiles = await picker.pickMultiImage();
    files.addAll(imagesListFiles);
    safePrint(files.length);
  }

  Future<void> uploadImages(List<XFile> images) async {
    final userId = auth.currentUser!.uid;
    try {
      for (XFile image in images) {
        File file = File(image.path);
        String fileName = file.path.split("/").last;
        Reference reference =
            FirebaseStorage.instance.ref().child("rayImage/$fileName/$userId");
        UploadTask uploadTask = reference.putFile(file);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        imagesList.add(downloadUrl);
      }
    } catch (e) {
    }
  }
}
