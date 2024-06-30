import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/send_notify.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/admin/model/admin_model.dart';
import 'package:enurse_system/features/authentication/register/requestState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../admin_doctors/model/doctor_model.dart';
import '../admin_nurse/model/nurse_list_model.dart';
part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  List<AdminModel> requestedDataModel = [];
  List<NurseDataModel> nurseListModel = [];
  List<DoctorDataModel> doctorListModel = [];

  //GET Nurse====================
  getNurses() {
    emit(AdminNurseLoadingState());
    fireStore
        .collection("users")
        .where("type", isEqualTo: "1").where("requestState", isEqualTo: RequestState.accepted.name)
        .snapshots()
        .listen((value) {
      nurseListModel.clear();
      for (var document in value.docs) {
        final patientData = NurseDataModel.fromMap(document.data());
        nurseListModel.add(patientData);
      }
      safePrint('==============' + "${nurseListModel.length}");
      safePrint(nurseListModel.length);
      emit(AdminNurseSuccessState());
    });
  }

  //GET Doctors===================================
  getDoctors() {
    emit(AdminDoctorLoadingState());
    fireStore
        .collection("users")
        .where("type", isEqualTo: "0").where("requestState", isEqualTo:RequestState.accepted.name )
        .snapshots()
        .listen((value) {
      doctorListModel.clear();
      for (var document in value.docs) {
        final doctorData = DoctorDataModel.fromMap(document.data());
        doctorListModel.add(doctorData);
      }
      safePrint('==============' + "${doctorListModel.length}");
      safePrint(doctorListModel.length);
      emit(AdminDoctorSuccessState());
    });
  }

  getRequestedData({required String type}) async {
    emit(GetRequestStateLoading());
    await fireStore
        .collection("users")
        .where('requestState', isEqualTo: RequestState.pending.name)
        .where(
          'type',
          isEqualTo: type,
        )
        .snapshots()
        .listen((value)  {
      requestedDataModel.clear();
      for (var doc in value.docs) {
        final requestedData = AdminModel.fromMap(doc.data());
        requestedDataModel.add(requestedData);
      }
      emit(GetRequestStateSuccess());
      //Future.delayed(Duration(seconds: 2));
    });
  }
  Future<void> deleteDoctor( DoctorDataModel doctors) async{
  emit(DeleteDoctorLoadingState());
  try{
    await FirebaseFirestore.instance
        .collection("users")
        .doc(doctors.id)
        .delete();
    emit(DeleteDoctorSuccessState());
  }catch(e){
    emit(DeleteDoctorFailureState(e.toString()));
  }
}
  Future<void> deleteNurse( NurseDataModel nurses) async {
    emit(DeleteNurseLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(nurses.id)
          .delete();
      emit(DeleteNurseSuccessState());
    } catch (e) {
      emit(DeleteNurseFailureState(e.toString()));
    }
  }
  Future changeRequest(
      {required String id,
      required bool accepted,
      required String type}) async {
    emit(UpdateRequestStateLoading());
    fireStore.collection("users").doc(id).update({
      "requestState":
          accepted ? RequestState.accepted.name : RequestState.rejected.name
    }).then((value) {
      safePrint("send notify");
      sendNotification(
        id: id,
        body: accepted ? 'accepted' : 'rejected',
      );
      safePrint("send notify");
      emit(UpdateRequestStateSuccess());
    }).catchError((onError) {
      safePrint("==>" + onError.toString());
      emit(UpdateRequestStateFailure(onError.toString()));
    });
  }
}
