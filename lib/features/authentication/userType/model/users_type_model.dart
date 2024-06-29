
// list local in the app
// list from firebase

class UsersTypeModel{
  String _image = '';
  String _name = "";
  String _id = "";
  bool _isSelected = false;

  UsersTypeModel(this._image, this._name, this._id,this._isSelected);

 UsersTypeModel.fromMap(Map<String,dynamic> data){
   _id = data['id'];
   _name = data["name"];
   _image = data['image'];

  }

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }
}