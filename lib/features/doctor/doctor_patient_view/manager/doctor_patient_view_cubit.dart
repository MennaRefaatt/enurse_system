import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../model/daily_report_model.dart';
part 'doctor_patient_view_state.dart';

class DoctorPatientViewCubit extends Cubit<DoctorPatientViewState> {
  DoctorPatientViewCubit() : super(DoctorPatientViewInitial());
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final now = DateTime.now();
  TextEditingController contentController = TextEditingController();
  void saveDailyNotes({required String patientId}) {
    emit(DailyReportLoading());
    DailyReportModel dailyReportModel = DailyReportModel(
      content: contentController.text,
      date:DateTime(now.year, now.month, now.day),
      patientId: patientId,
    );
    firestore
        .collection("dailyReport")
        .doc(DateTime(now.year, now.month, now.day).toString())
        .set(dailyReportModel.toMap())
        .then((value) {
      contentController.clear();
      emit(DailyReportSuccess());
    });
  }
}
