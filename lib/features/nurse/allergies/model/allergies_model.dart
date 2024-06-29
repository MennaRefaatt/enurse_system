class AllergiesModel {
  String _avoidFood = '';
  String _chemicalSides = '';
  String _patientName = '';
  String _patientId='';

  AllergiesModel({required String avoidFood, required String chemicalSides, required String patientName,required String patientId}) {
    _avoidFood = avoidFood;
    _chemicalSides = chemicalSides;
    _patientName = patientName;
    _patientId = patientId;

  }

  String get avoidFood => _avoidFood ?? '';

  set avoidFood(String value) {
    _avoidFood = value;
  }

  String get chemicalSides => _chemicalSides ?? '';

  set chemicalSides(String value) {
    _chemicalSides = value;
  }

  String get patientName => _patientName;

  set patientName(String value) {
    _patientName = value;
  }
  String get patientId => _patientId;

  set patientId(String value) {
    _patientId = value;
  }

  AllergiesModel.fromMap(Map<dynamic, dynamic> data) {
    _chemicalSides = data['chemicalSides'];
    _avoidFood = data['avoidFood'];
    _patientName = data['patientName'];
    _patientId=data['patientId'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['chemicalSides'] = _chemicalSides;
    map['avoidFood'] = _avoidFood;
    map['patientName'] = _patientName;
    map['patientId']=_patientId;

    return map;
  }
}
