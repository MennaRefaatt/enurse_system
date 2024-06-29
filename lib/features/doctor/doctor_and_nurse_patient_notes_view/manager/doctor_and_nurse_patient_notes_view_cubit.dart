import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../patient/patient_home/model/notes_model.dart';

part 'doctor_and_nurse_patient_notes_view_state.dart';

class DoctorAndNursePatientNotesViewCubit extends Cubit<DoctorAndNursePatientNotesViewState> {
  DoctorAndNursePatientNotesViewCubit() : super(DoctorAndNursePatientNotesViewInitial());

  TextEditingController contentController = TextEditingController();
  TextEditingController displayContentController = TextEditingController();
  List<NotesModel> notes = [];
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  void getNotes({required String patientId}) {
    emit(GetDoctorAndNursePatientNotesViewLoadingState());
    firestore
        .collection('patient-notes')
        .where('patientId', isEqualTo:patientId)
        .snapshots()
        .listen((value) {
      notes.clear(); //to not repeat the info
      for (var document in value.docs) {
        final note = NotesModel.fromMap(document.data());
        notes.add(note);
      }
      safePrint(notes.length);
      safePrint(notes.toString());
      emit(GetDoctorAndNursePatientNotesViewSuccessState());
    });
  }



  Future<void> deleteNotes(NotesModel notesModel) async {
    emit(DeleteDoctorAndNursePatientNotesViewLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection("patient-notes")
          .doc(notesModel.documentId)
          .delete();
      emit(DeleteDoctorAndNursePatientNotesViewSuccessState());
    } catch (e) {
      emit(DeleteDoctorAndNursePatientNotesViewFailureState(e.toString()));
    }
  }
}