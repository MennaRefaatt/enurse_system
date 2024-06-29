import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/nurse/test_results/model/test_result_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
part 'test_results_state.dart';

class TestResultsCubit extends Cubit<TestResultsState> {
  TestResultsCubit() : super(TestResultsInitial());
  final picker = ImagePicker();
  final auth = FirebaseAuth.instance;
  String id = '';
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  List<TestResultModel> testResultModel = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String date = "";
  List<String> imagesList = [];
  final List<XFile> files = [];
  getTestResults({required String patientId}) {
    emit(GetTestResultsLoadingState());
    fireStore
        .collection("testResults")
        .where('patientId', isEqualTo: patientId)
        .snapshots()
        .listen((value) {
      testResultModel.clear();
      for (var document in value.docs) {
        final testResult = TestResultModel.fromMap(document.data());
        testResultModel.add(testResult);
      }
      safePrint(testResultModel.length);
      emit(GetTestResultsSuccessState());

    });
  }

  Future<void> deleteTestResults(TestResultModel testResultModel) async {
    emit(DeleteTestResultsLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection("testResults")
          .doc(testResultModel.documentId)
          .delete();
      emit(DeleteTestResultsSuccessState());
    } catch (e) {
      emit(DeleteTestResultsFailureState(e.toString()));
    }
  }


  saveTestResultData({required String patientId}) {
    emit(AddTestResultsLoadingState());
    DateTime dateTime = DateTime.now();
    TestResultModel testResultModel = TestResultModel(
      title: nameController.text,
      date: date,
      images: imagesList,
      patientId: patientId,
      documentId: dateTime.toString(),
    );

    uploadImages(files).then((value) {
      fireStore
          .collection("testResults")
          .doc(dateTime.toString())
          .set(testResultModel.toMap())
          .then((value) async {
        emit(AddTestResultsSuccessState());
        nameController.clear();
        dateController.clear();
        imagesList.clear();
        files.clear();
      }).catchError((e) {
        emit(AddTestResultsFailureState(e.toString()));
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
        Reference reference = FirebaseStorage.instance
            .ref()
            .child("testResultImage/$fileName/$userId");
        UploadTask uploadTask = reference.putFile(file);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        imagesList.add(downloadUrl);
      }
    } catch (e) {
    }
  }
}
