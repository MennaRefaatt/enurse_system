class MedicationsModel{
  String _name="";
  String _start="";
  String _end="";
  String _dosage="";


  MedicationsModel({required String name,
    required String start,
    required String end,
    required String dosage}) {
    _start=start;
    _end=end;
    _name=name;
    _dosage=dosage;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
  MedicationsModel.fromMap(Map<dynamic,dynamic> data){
    _name = data['name'];
    _start = data['start'];
    _end = data['end'];
    _dosage = data['dosage'];

  }

  Map<String,dynamic> toMap(){
    final map = <String, dynamic>{};
    map['name']= _name;
    map['start']= _start;
    map['end']= _end;
    map['dosage']= _dosage;
    return map;
  }

  String get start => _start;

  set start(String value) {
    _start = value;
  }

  String get end => _end;

  set end(String value) {
    _end = value;
  }

  String get dosage => _dosage;

  set dosage(String value) {
    _dosage = value;
  }
}