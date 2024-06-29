class AdminModel{
  String _name="";
  String _id="";
  String _image="";

  AdminModel({required String name,
    required String id,
    required String image}){
    _name=name;
    _image=image;
    _id=id;
  }
  AdminModel.fromMap(Map<dynamic,dynamic> data){
    _name = data['name'];
   _image=data["imageUrl"];
   _id=data["id"];
  }
  Map<String,dynamic> toMap(){
    final map = <String, dynamic>{};
    map['name']= _name;
    map['id']=_id;
    map['imageUrl']=_image;

    return map;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }



  String get name => _name;

  set name(String value) {
    _name = value;
  }
}

