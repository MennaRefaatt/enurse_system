import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DailyReportModel {
  String _content;
  String _doctorId;
  DateTime _date;
  String _patientId;

  DailyReportModel({
    required String content,
    required DateTime date,
    required String patientId,
  })  : _content = content,
        _date = date,
        _patientId = patientId,
        _doctorId = FirebaseAuth.instance.currentUser?.uid ?? '';

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  DailyReportModel.fromMap(Map<String, dynamic> data)
      : _doctorId = data['doctor_id'],
        _patientId = data['patient_id'],
        _date = (data['date'] as Timestamp).toDate(),
        _content = data['content'];

  Map<String, dynamic> toMap() {
    return {
      "content": _content,
      "patient_id": _patientId,
      "doctor_id": _doctorId,
      "date": Timestamp.fromDate(_date),
    };
  }


  String get doctorId => _doctorId;

  set doctorId(String value) {
    _doctorId = value;
  }

  String get patientId => _patientId;

  set patientId(String value) {
    _patientId = value;
  }
}
