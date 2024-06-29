class FamilyModel{
  String _kinShip="";
  String _patientId="";

  FamilyModel({required String kinShip, required String patientId}) {
    _kinShip=kinShip;
    _patientId=patientId;
  }

  Map<String,dynamic> toMap(){
    return{
      "kindShip":kinShip,
      "patientId":patientId,
    };
  }
  String get patientId => _patientId;

  set patientId(String value) {
    _patientId = value;
  }

  String get kinShip => _kinShip;

  set kinShip(String value) {
    kinShip = value;
  }
}