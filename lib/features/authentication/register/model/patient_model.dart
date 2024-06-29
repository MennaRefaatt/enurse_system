class PatientMoodel {
  List _vitalSigns = [];
  List _allergies = [];
  List _rayes = [];
  List _medicalHistory = [];
  List _testResults = [];
  List _notes = [];
  List _dailyReport = [];
  String _nurseId = "";
  String _roomNumber = "";

  PatientMoodel(
      this._allergies,
      this._dailyReport,
      this._medicalHistory,
      this._notes,
      this._nurseId,
      this._rayes,
      this._testResults,
      this._vitalSigns,
      this._roomNumber);

  Map<String, dynamic> toMap() {
    return {
      "vitalSigns": [vitalSigns],
      "allergies": [allergies],
      "rayes": [rayes],
      "medicalHistory": [medicalHistory],
      "testResults": [testResults],
      "notes": [notes],
      "roomNumber": roomNumber,
      "dailyReport": [dailyReport],
      "nurseId": nurseId
    };
  }

  List<dynamic> get vitalSigns => _vitalSigns;

  set vitalSigns(List<dynamic> value) {
    _vitalSigns = value;
  }

  List<dynamic> get allergies => _allergies;

  set allergies(List<dynamic> value) {
    _allergies = value;
  }

  List<dynamic> get rayes => _rayes;

  set rayes(List<dynamic> value) {
    _rayes = value;
  }

  List<dynamic> get medicalHistory => _medicalHistory;

  set medicalHistory(List<dynamic> value) {
    _medicalHistory = value;
  }

  List<dynamic> get testResults => _testResults;

  set testResults(List<dynamic> value) {
    _testResults = value;
  }

  List<dynamic> get notes => _notes;

  set notes(List<dynamic> value) {
    _notes = value;
  }

  List<dynamic> get dailyReport => _dailyReport;

  set dailyReport(List<dynamic> value) {
    _dailyReport = value;
  }

  String get nurseId => _nurseId;

  set nurseId(String value) {
    _nurseId = value;
  }

  String get roomNumber => _roomNumber;

  set roomNumber(String value) {
    _nurseId = value;
  }
}
