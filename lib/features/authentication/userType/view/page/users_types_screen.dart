import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/authentication/login/view/page/login_screen.dart';
import 'package:enurse_system/features/authentication/userType/manager/user_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UsersTypesScreen extends StatefulWidget {
  UsersTypesScreen({super.key});

  @override
  State<UsersTypesScreen> createState() => _UsersTypesScreenState();
}

class _UsersTypesScreenState extends State<UsersTypesScreen> {
  final cubit = UserTypeCubit();
  String type = '';
  @override
  void initState() {
    super.initState();
    cubit.getTypes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getTypes(),
      child: BlocBuilder<UserTypeCubit, UserTypeState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.all(15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome \nWho are you?",
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: false,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: cubit.usersTypeModel.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(14.sp),
                            onTap: () {
                              for (int item = 0;
                                  item < cubit.usersTypeModel.length;
                                  item++) {
                                cubit.usersTypeModel[item].isSelected = false;
                              }
                              cubit.usersTypeModel[index].isSelected = true;
                              type = cubit.usersTypeModel[index].id;
                              safePrint(type);
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.all(13.sp),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: lightPurpleColor.withOpacity(.3),
                                      spreadRadius: 0.1,
                                      blurRadius: 7,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(14.sp),
                                  color: !cubit.usersTypeModel[index].isSelected
                                      ? Colors.grey[300]
                                      : lightPurpleColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cubit.usersTypeModel[index].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 6.h,
                      child: ElevatedButton(
                        onPressed: type.isNotEmpty
                            ? () {
                                push(
                                    context,
                                    LoginScreen(
                                      type: type,
                                    ));
                              }
                            : null,
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w300),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(14.sp))),
                            backgroundColor: MaterialStatePropertyAll(
                                type.isNotEmpty
                                    ? lightPurpleColor
                                    : Colors.grey[300])),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
