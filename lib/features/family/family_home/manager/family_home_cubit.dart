import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import '../../../doctor/doctor_patient_view/model/daily_report_model.dart';
import '../../../doctor/patient_log/model/medications.dart';
part 'family_home_state.dart';

class FamilyHomeCubit extends Cubit<FamilyHomeState> {
  FamilyHomeCubit() : super(FamilyHomeInitial());

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  List<MedicationsModel> medicationModel = [];
  final fireStore = FirebaseFirestore.instance;
  List<DailyReportModel> dailyReport = [];
  // final now = DateTime.now();
  // late DateTime today = DateTime(now.year, now.month, now.day);
  // late DateTime tomorrow = today.add(const Duration(days: 1));
  // Add 1 day for the end boundary
  getMedications() {
    emit(FamilyHomeLoadingState());
    firestore.collection("set-medications").snapshots().listen((value) {
      medicationModel.clear();
      for (var documents in value.docs) {
        final medicationsData = MedicationsModel.fromMap(documents.data());
        medicationModel.add(medicationsData);
      }
      safePrint("======================" + "${medicationModel.length}");
      safePrint(medicationModel.length);
      emit(FamilyHomeSuccessState());
    });
  }

  //==================================================

  void getDailyReport({required String patientId}) {
    emit(FamilyHomeLoadingState());
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    fireStore
        .collection("dailyReport")
        .where("date", isGreaterThanOrEqualTo: today, isLessThan: tomorrow)
        //.where("patient_id", isEqualTo: patientId)
        .orderBy('date', descending: true)
        .startAt([today])
        .snapshots()
        .listen((value) {
      dailyReport.clear();
      for (var document in value.docs) {
        final dailyReportModel = DailyReportModel.fromMap(document.data());
        dailyReport.add(dailyReportModel);
      }
      //safePrint(DateTime(now.year, now.month, now.day).toString());
      safePrint(dailyReport.length);
      emit(FamilyHomeSuccessState());
    });
  }
}