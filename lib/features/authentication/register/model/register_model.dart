class RegisterModel {
  String _id = '';
  String _type = "";
  String _name = "";
  String _email = "";
  String _phone = "";
  String _ssn = "";
  String _gender = "";
  String _age = "";
  String _deviceToken = "";
  String _requestState = "";
  String _imageUrl = "";

  RegisterModel(
    this._deviceToken,
    this._name,
    this._email,
    this._phone,
    this._ssn,
    this._gender,
    this._age,
    this._id,
    this._type,
      this._requestState,
      this._imageUrl,

  );


  String get imageUrl => _imageUrl;

  String get requestState => _requestState;

  String get deviceToken => _deviceToken;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  Map<String, dynamic> toMap() {
    return {
      "deviceToken": deviceToken,
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "ssn": ssn,
      "gender": gender,
      "age": age,
      "type": type,
      "requestState" : requestState,
      "imageUrl" : imageUrl,

    };
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


}
