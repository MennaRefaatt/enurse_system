
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/nurse/patient_information_screen/manager/patient_information_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../doctor/doctor_patient_view/model/daily_report_model.dart';
class PatientInformationCubit extends Cubit<PatientInformationState> {
  PatientInformationCubit() : super(PatientInformationInitial());
  String name = "";
  String patientProblem = "";
  CollectionReference patientInfo =
      FirebaseFirestore.instance.collection("users");
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  List<DailyReportModel> dailyReport = [];
  final now = DateTime.now();
  late DateTime today = DateTime(now.year, now.month, now.day);
  late DateTime tomorrow = today.add(const Duration(days: 1));  // Add 1 day for the end boundary




  Stream<QuerySnapshot<Map<String, dynamic>>> getPatients() {
    return FirebaseFirestore.instance
        .collection("users")
        .where("type", isEqualTo: "2")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? patientStream;

  getOnTheLoad() async {
    patientStream = await getPatients();
  }

  void getDailyReport({required String patientId}) {
    emit(DailyReportLoadingState());
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    fireStore
        .collection("dailyReport")
        .where("date", isGreaterThanOrEqualTo: today, isLessThan: tomorrow)
        .where("patient_id", isEqualTo: patientId)
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
      emit(PatientInformationSuccessState());
    });
  }
}
