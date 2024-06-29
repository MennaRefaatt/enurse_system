class NurseDataModel {
  String _name = '';
  String _id = '';
  String _healthcareInstitute = '';
  String _phone = '';
  String _ssn = '';
  String _age = '';
  String _gender='';
  String _specialization='';
  String _email='';

  NurseDataModel(this._name, this._id, this._healthcareInstitute, this._phone,
      this._ssn,this._age,this._gender,this._specialization,this._email);

  NurseDataModel.fromMap(Map<dynamic, dynamic> data) {
    _name = data['name'];
    _id = data['id'];
    _healthcareInstitute = data['healthcareInstitute'];
    _phone = data['phone'];
    _ssn = data['ssn'];
    _age =data['age'];
    _gender=data['gender'];
    _specialization=data['specialization'];
    _email=data['email'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    map['healthcareInstitute'] = _healthcareInstitute;
    map['phone'] = _phone;
    map['ssn'] = _ssn;
    map['age']=_age;
    map['specialization']=_specialization;
    map['gender']=_gender;
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
  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get healthcareInstitute => _healthcareInstitute;

  set healthcareInstitute(String value) {
    _healthcareInstitute = value;
  }


  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get ssn => _ssn;

  set ssn(String value) {
    _ssn = value;
  }
  String get age => _age;

  set age(String value) {
    _age = value;
  }
  String get specialization => _specialization;

  set specialization(String value) {
    _specialization = value;
  }
  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }
}