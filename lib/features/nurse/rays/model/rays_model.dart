class RaysModel{
  String? _title;
  List<dynamic>? _images;
  String? _date;
  late String _documentId;
  late String _patientId;


  RaysModel({
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


  RaysModel.fromMap(Map<dynamic,dynamic> data){
    _title = data['rayName'];
    _images = data['rayImage'];
    _documentId =data["documentId"];
    _date = data['rayDate'];
  }
  Map<String,dynamic> toMap(){
    final map = <String, dynamic>{};
    map['rayName']= _title;
    map['rayImage']= _images;
    map['rayDate']= _date;
    map["patientId"]=_patientId;
    map["documentId"]=_documentId;
    return map;
  }





  List<dynamic> get images => _images ?? [];

  String get date => _date ?? "";

  String get patientId => _patientId;

  set patientId(String value) {
    _patientId = value;
  }

  String get documentId => _documentId;

  set documentId(String value) {
    _documentId = value;
  }
}