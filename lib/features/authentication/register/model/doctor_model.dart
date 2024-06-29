class DoctorAndNurseModel{
  String _specialization="";
  String _healthcareInstitute="";

  DoctorAndNurseModel({required String specialization, required String healthcareInstitute}){
    _specialization  = specialization;
    _healthcareInstitute =   healthcareInstitute;
  }


  Map<String,dynamic> toMap(){
    return{
      "specialization" : specialization,
      "healthcareInstitute":healthcareInstitute,
    };
  }

  String get healthcareInstitute => _healthcareInstitute;

  set healthcareInstitute(String value) {
    _healthcareInstitute = value;
  }

  String get specialization => _specialization;

  set specialization(String value) {
    _specialization = value;
  }
}