class MedicationsModel {
  String _name = '';
  String _dosage = '';
  String _start = '';
  String _end = '';

  MedicationsModel(this._dosage, this._end, this._name, this._start);

  MedicationsModel.fromMap(Map<dynamic, dynamic> data) {
    _name = data['name'];
    _start = data['start'];
    _end = data['end'];
    _dosage = data['dosage'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['start'] = _start;
    map['end'] = _end;
    map['dosage'] = _dosage;
    return map;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get start => _start;

  set start(value) {
    value = _start;
  }

  String get end => _end;

  set end(String value) {
    value = _end;
  }

  String get dosage => _dosage;

  set dosage(String value) {
    _dosage = value;
  }
}