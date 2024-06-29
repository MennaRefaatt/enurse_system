import 'package:firebase_auth/firebase_auth.dart';

class NotesModel {
  String _content = '';
  String _date = '';
  late String _documentId;
  late String _patientId;

  NotesModel({
    required String content,
    required String date,
    required String documentId,}) {
    _content = content;
    _date = date;
    _documentId=documentId;
    _patientId = FirebaseAuth.instance.currentUser!.uid ;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  NotesModel.fromMap(Map<dynamic, dynamic> data) {
    _patientId = data['patientId'];
    _documentId =data["documentId"];
    _date = data['date'];
    _content = data['content'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map["content"] = _content;
    map["patientId"] = _patientId;
    map["date"] = _date;
    map["documentId"]=_documentId;
    return map;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get patientId => _patientId;

  set patientId(String value) {
    _patientId = value;
  }

  String get documentId => _documentId;

  set documentId(String value) {
    _documentId = value;
  }
}
