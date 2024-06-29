import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../model/notes_model.dart';
part 'patient_home_state.dart';

class PatientHomeCubit extends Cubit<PatientHomeState> {
  PatientHomeCubit() : super(PatientHomeInitial());

  TextEditingController contentController = TextEditingController();
  TextEditingController displayContentController = TextEditingController();
  List<NotesModel> notes = [];
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  void addNewNote() {
    emit(AddPatientHomeLoadingState());
    DateTime dateTime = DateTime.now();
    NotesModel notes = NotesModel(
      content: contentController.text,
      date:"${DateFormat.yMEd().add_jms().format(DateTime.now())}",
        documentId: dateTime.toString(),
    );
    firestore
        .collection("patient-notes")
        .doc(dateTime.toString())
        .set(notes.toMap())
        .then((value) {
      contentController.clear();
      emit(AddPatientHomeSuccessState());
    }).catchError((error) {
      emit(AddPatientHomeFailureState(error.toString()));
    });
  }

  void getNotes() {
    emit(GetPatientHomeLoadingState());
    final userId = FirebaseAuth.instance.currentUser?.uid;
    firestore
        .collection('patient-notes')
        .where('patientId', isEqualTo: userId)
        .snapshots()
        .listen((value) {
      notes.clear(); //to not repeat the info
      for (var document in value.docs) {
        final note = NotesModel.fromMap(document.data());
        notes.add(note);
      }
      safePrint(notes.toString());
      emit(GetPatientHomeSuccessState());
    });
  }
}
