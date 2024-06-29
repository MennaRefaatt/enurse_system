class PatientRegisterModel {
  String _patientId = '';
  String _type = "";
  String _name = "";
  String _email = "";
  String _phone = "";
  String _ssn = "";
  String _gender = "";
  String _age = "";
  String _deviceToken = "";
  String _roomNumber = "";
  String _NurseId = "";
  String _entryDate = "";
  String _city="";
  String _patientProblem="";

  PatientRegisterModel(
      this._deviceToken,
      this._name,
      this._email,
      this._phone,
      this._ssn,
      this._gender,
      this._age,
      this._patientId,
      this._type,
      this._roomNumber,
      this._NurseId,
      this._entryDate,
      this._city,
      this._patientProblem
      );
  String get patientProblem => _patientProblem;

  set patientProblem(String value) {
    _patientProblem = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get entryDate => _entryDate;

  set entryDate(String value) {
    _entryDate = value;
  }

  String get deviceToken => _deviceToken;

  set deviceToken(String value) {
    _deviceToken = value;
  }

  String get nurseId => _NurseId;

  set nurseId(String value) {
    _NurseId = value;
  }

  String get roomNumber => _roomNumber;

  set roomNumber(String value) {
    _roomNumber = value;
  }

  String get patientId => _patientId;

  set patientId(String value) {
    _patientId = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get age => _age;

  set age(String value) {
    _age = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }

  String get ssn => _ssn;

  set ssn(String value) {
    _ssn = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
  Map<String, dynamic> toMap() {
    return {
      "deviceToken": deviceToken,
      "id": patientId,
      "name": name,
      "email": email,
      "phone": phone,
      "ssn": ssn,
      "gender": gender,
      "age": age,
      "type": type,
      "roomNumber": roomNumber,
      "nurseId": nurseId,
      "entryDate": entryDate,
      "city" : city,
      "patientProblem" : patientProblem,

    };
  }

}
