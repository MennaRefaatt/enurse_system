import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../doctor/patient_log/model/medications.dart';

part 'ehrscreen_state.dart';

class EhrScreenCubit extends Cubit<EhrscreenState> {
  EhrScreenCubit() : super(EhrScreenInitial());

  // Stream? medicationsStream;

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String name='';
  List<MedicationsModel> medicationModel = [];

  getMedications({required String patientId}) {
    emit(EhrscreenLoadingState());
    final userId = FirebaseAuth.instance.currentUser?.uid;

    firestore
        .collection("set-medications")
        .where('patient_id', isEqualTo: patientId)
        .snapshots()
        .listen((value) {
      medicationModel.clear();
      for (var documents in value.docs) {
        final medicationsData = MedicationsModel.fromMap(documents.data());
        medicationModel.add(medicationsData);
      }
      safePrint("======================" + "${medicationModel.length}");
      safePrint(medicationModel.length);
      emit(EhrscreenSuccessState());
    });
  }
// Future<Stream<QuerySnapshot>> getMedications() async {
//   return await FirebaseFirestore.instance
//       .collection("set-medications")
//       .snapshots();
// }
//
// getOnTheLoad() async {
//   medicationsStream = await getMedications();
// }
}