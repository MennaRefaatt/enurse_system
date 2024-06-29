import 'package:firebase_auth/firebase_auth.dart';

class DailyReportModel{
  String _content='';
  String _userId='';
 var _date;
  String _patientId="";


  DailyReportModel({
    required String content,
    required var date,
    required String patientId}) {
    _content=content;
    _date=date;
    userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    _patientId = patientId;
  }



  String get content => _content;

  set content(String value) {
    _content = value;
  }

  get date => _date;

  set date(value) {
    _date = value;
  }

  DailyReportModel.fromMap(Map<dynamic,dynamic> data){
    _userId =data ['userId'];
    _patientId = data['patient_id'];
    _date =data ['date'];
    _content =data ['content'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map["content"]=_content;
    map['patient_id'] = _patientId;
    map["userId"]=_userId;
    map["date"]=_date;
    return map;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  String get patientId => _patientId;

  set patientId(String value) {
    _patientId = value;
  }
}