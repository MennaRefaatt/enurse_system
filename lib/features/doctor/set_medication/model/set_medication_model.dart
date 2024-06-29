import 'package:intl/intl.dart';

class SetMedicationModel {
  String _name = "";
  DateTime _start;
  DateTime _end;
  String _dosage = "";
  String _patientId = '';

  SetMedicationModel(
      this._name, this._start, this._end, this._dosage, this._patientId);

  String get patientId => _patientId;

  set patientId(String value) {
    _patientId = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['patient_id'] = _patientId;
    map['start'] = DateFormat('dd-MM-yyyy').format(_start);
    map['end'] = DateFormat('dd-MM-yyyy').format(_end);
    map['dosage'] = _dosage;
    return map;
  }

  DateTime get start => _start;

  set start(DateTime value) {
    _start = value;
  }

  String get dosage => _dosage;

  set dosage(String value) {
    _dosage = value;
  }

  DateTime get end => _end;

  set end(DateTime value) {
    _end = value;
  }
}
