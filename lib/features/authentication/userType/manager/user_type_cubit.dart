import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/authentication/userType/model/users_type_model.dart';
import 'package:meta/meta.dart';

part 'user_type_state.dart';

class UserTypeCubit extends Cubit<UserTypeState> {
  UserTypeCubit() : super(UserTypeInitial());
  List<UsersTypeModel> usersTypeModel = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  getTypes(){
    firestore.collection("usersTypes").get().then((value) {

      usersTypeModel.clear();
      for(var document in value.docs){
        final type = UsersTypeModel.fromMap(document.data());
        usersTypeModel.add(type);
      }
      emit(UserTypeSuccess());
      safePrint(usersTypeModel);

    });

  }


}
