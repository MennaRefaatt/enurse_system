class TestResultModel{
  String? _title;
  List<dynamic>? _images;
  String? _date;
  late String _documentId;
  late String _patientId;


  TestResultModel({
    required String documentId,
    required String title,
    required String date,
    required List<String> images,
    required String patientId
}){
    _documentId=documentId;
    _title = title;
    _images = images;
    _date = date;
    _patientId = patientId;

  }

  String get title => _title ?? "";

  set title(String value) {
    _title = value;
  }


  TestResultModel.fromMap(Map<dynamic,dynamic> data){
    _title = data['testResultName'];
    _images = data['testResultImage'];
    _date = data['testResultDate'];
    _documentId =data["documentId"];
  }
  Map<String,dynamic> toMap(){
    final map = <String, dynamic>{};
    map['testResultName']= _title;
    map['testResultImage']= _images;
    map['testResultDate']= _date;
    map["patientId"]=_patientId;
    map["documentId"]=_documentId;
    return map;
}
  String get documentId => _documentId;

  set documentId(String value) {
    _documentId = value;
  }

  String get patientId => _patientId;

  set patientId(String value) {
    _patientId = value;
  }
  List<dynamic> get images => _images ?? [];

  String get date => _date ?? "";
}