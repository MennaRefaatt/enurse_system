class PatientDataModel {
  String _name = '';
  String _id = '';
  String _email = '';
  String _entryDate = '';
  String _age = '';
  String _roomNumber = '';
  String _gender = '';
  String _ssn = '';
  String _phone = '';
  String _city = '';
  String _patientProblem = '';

  PatientDataModel(
      this._name,
      this._id,
      this._email,
      this._phone,
      this._age,
      this._gender,
      this._ssn,
      this._city,
      this._entryDate,
      this._roomNumber,
      this._patientProblem);

  PatientDataModel.fromMap(Map<dynamic, dynamic> data) {
    _name = data['name'];
    _id = data['id'];
    _entryDate = data['entryDate'];
    _roomNumber = data['roomNumber'];
    _email = data['email'];
    _gender = data['gender'];
    _ssn = data["ssn"];
    _city = data['city'];
    _age = data['age'];
    _phone = data['phone'];
    _patientProblem = data['patientProblem'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    map['entryDate'] = _entryDate;
    map['roomNumber'] = _roomNumber;
    map['ssn'] = _ssn;
    map['city'] = _city;
    map['age'] = _age;
    map['email'] = _email;
    map['gender'] = _gender;
    map['phone'] = _phone;
    map['patientProblem'] = _patientProblem;

    return map;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get entryDate => _entryDate;

  set entryDate(String value) {
    _entryDate = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get ssn => _ssn;

  set ssn(String value) {
    _ssn = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }

  String get age => _age;

  set age(String value) {
    _age = value;
  }

  String get roomNumber => _roomNumber;

  set roomNumber(String value) {
    _roomNumber = value;
  }

  String get patientProblem => _patientProblem;

  set patientProblem(String value) {
    _patientProblem = value;
  }
}
