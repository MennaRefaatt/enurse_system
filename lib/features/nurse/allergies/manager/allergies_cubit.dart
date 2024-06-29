import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/nurse/allergies/model/allergies_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

part 'allergies_state.dart';

class AllergiesCubit extends Cubit<AllergiesState> {
  AllergiesCubit() : super(AllergiesInitial());
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  TextEditingController avoidFoodsController = TextEditingController();
  TextEditingController chemicalSidesController = TextEditingController();
  List<AllergiesModel> allergiesModel = [];

  getAllergies({required String patientId}) {
    emit(GetAllergiesLoadingState());
    fireStore
        .collection("allergies")
        .where("patientId", isEqualTo: patientId)
        .snapshots()
        .listen((value) {
      allergiesModel.clear();
      avoidFoodsController.clear();
      chemicalSidesController.clear();
      for (var document in value.docs) {
        final allergiesData = AllergiesModel.fromMap(document.data());
        allergiesModel.add(allergiesData);
      }
      safePrint(allergiesModel.length);
      emit(GetAllergiesSuccessState());});
  }

  void saveAllergiesData(
      {required String patientId, required String patientName}) {
    emit(AddAllergiesLoadingState());
    AllergiesModel allergiesModel = AllergiesModel(
      avoidFood: avoidFoodsController.text,
      chemicalSides: chemicalSidesController.text,
      patientName: patientName,
      patientId: patientId,
    );
    fireStore
        .collection("allergies")
        .doc()
        .set(allergiesModel.toMap())
        .then((value) async{
     // getAllergies(patientId: patientId);
      emit(AddAllergiesSuccessState());
      avoidFoodsController.clear();
      chemicalSidesController.clear();
      Fluttertoast.showToast(
          msg: "Allergies Added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black12,
          textColor: Colors.black,
          fontSize: 16.0.sp);

    }).catchError((e) {
      emit(AddAllergiesFailureState(e.toString()));
    });
  }
}
