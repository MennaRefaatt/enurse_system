class MedicalHistoryModel {
  String _disease='';
  String _dateOfIllness='';
  String _treatedOrNOt='';
  String _medication='';
  String _patientId='';
  String _patientName='';

  MedicalHistoryModel(
      {required String dateOfIllness,
      required String disease,
      required String medication,
      required String treatedOrNOt,
      required String patientId,
      required String patientName}) {
    _disease = disease;
    _dateOfIllness = dateOfIllness;
    _treatedOrNOt = treatedOrNOt;
    _medication = medication;
    _patientId = patientId;
    _patientName = patientName;
  }

  String get disease => _disease ;

  set disease(String value) {
    _disease = value;
  }

  String get dateOfIllness => _dateOfIllness;

  set dateOfIllness(String value) {
    _dateOfIllness = value;
  }

  String get treatedOrNOt => _treatedOrNOt ;

  set treatedOrNOt(String value) {
    _treatedOrNOt = value;
  }

  String get medications => _medication ;

  set medications(String value) {
    _medication = value;
  }

  String get patientName => _patientName ;

  set patientName(String value) {
    _patientName = value;
  }

  String get patientId => _patientId ;

  set patientId(String value) {
    _patientId = value;
  }

  MedicalHistoryModel.fromMap(Map<dynamic, dynamic> data) {
    _disease = data['diseaseName'];
    _dateOfIllness = data['dateOfIllness'];
    _treatedOrNOt = data['treatedOrNOt'];
    _medication = data['medication'];
    _patientName = data['patientName'];
    _patientId = data['patientId'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['diseaseName'] = _disease;
    map['dateOfIllness'] = _dateOfIllness;
    map['treatedOrNOt'] = _treatedOrNOt;
    map['medication'] = _medication;
    map['patientName'] = _patientName;
    map['patientId'] = _patientId;
    return map;
  }
}
