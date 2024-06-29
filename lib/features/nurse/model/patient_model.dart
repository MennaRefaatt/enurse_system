class PatientModel{

  String _name="";
  String _image="";
  String _conditionName="";
  String _conditionNumber="";

  PatientModel(
      this._name, this._image, this._conditionName, this._conditionNumber);

  String get conditionNumber => _conditionNumber;

  set conditionNumber(String value) {
    _conditionNumber = value;
  }

  String get conditionName => _conditionName;

  set conditionName(String value) {
    _conditionName = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}