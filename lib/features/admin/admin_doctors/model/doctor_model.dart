class DoctorDataModel {
  String _name = '';
  String _id = '';
  String _phone = '';
  String _specialization = '';
  String _healthcareInstitute = '';
  String _SSN = '';
  String _age = '';
  String _email ='';


  DoctorDataModel(this._name, this._id,this._email,this._specialization,this._age,this._phone,this._SSN,this._healthcareInstitute);

  DoctorDataModel.fromMap(Map<dynamic, dynamic> data) {
    _name = data['name'];
    _id = data['id'];
    _phone=data['phone'];
    _specialization=data['specialization'];
    _healthcareInstitute=data['healthcareInstitute'];
    _SSN=data['ssn'];
    _age=data['age'];
    _email=data['email'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    map['phone']=_phone;
    map['specialization']=_specialization;
    map['healthcareInstitute']=_healthcareInstitute;
    map['ssn']=_SSN;
    map['age']=_age;
    map['email']=_email;

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
  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }
  String get ssn => _SSN;

  set ssn(String value) {
    _SSN = value;
  }
  String get specialization => _specialization;

  set specialization(String value) {
    _specialization = value;
  }
  String get healthcareInstitute => _healthcareInstitute;

  set healthcareInstitute(String value) {
    _healthcareInstitute = value;
  }
  String get age => _age;

  set age(String value) {
    _age = value;
  }
  String get email => _email;

  set email(String value) {
    _email = value;
  }
}