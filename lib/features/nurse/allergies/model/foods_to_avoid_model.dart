import 'allergies_model.dart';

class FoodsToAvoidModel  {
  String? name;
  String? id;

  FoodsToAvoidModel(this.name, this.id);

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

  // factory FoodsToAvoidModel.fromMap(Map<String, dynamic> data) {
  //   return FoodsToAvoidModel(
  //     // name: data['name'],
  //     // id: data['id'],
  //   );
  // }

}
