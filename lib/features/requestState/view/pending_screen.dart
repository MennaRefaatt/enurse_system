import 'dart:async';
import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/features/authentication/login/view/page/login_screen.dart';
import 'package:enurse_system/features/authentication/register/requestState.dart';
import 'package:enurse_system/features/requestState/manager/request_state_cubit.dart';
import 'package:enurse_system/shared/my_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PendingScreen extends StatefulWidget {
  PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  final cubit = RequestStateCubit();
  late Timer timer;
  double dimension = 35;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      setState(() {
        dimension = dimension == 25 ? 30 : 25;
      });
    });
    cubit.checkRequestState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<RequestStateCubit, RequestStateState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: darkPurpleColor,
            body: Container(
              margin: EdgeInsets.all(15.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Visibility(
                      visible: cubit.requestState == RequestState.pending.name,
                      child: Column(
                        children: [
                          Container(
                            height: 35.h,
                            child: AnimatedContainer(
                                duration: Duration(milliseconds: 700),
                                width: dimension.w,
                                height: dimension.h,
                                //padding: EdgeInsets.all(15.sp),
                                child: Image.asset(
                                  "assets/icons/loading.png",
                                  height: 50.h,
                                  width: 50.w,
                                )),
                          ),
                          Text(
                            "Please Wait!\nYour registration request is under processing",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Visibility(
                      visible: cubit.requestState == RequestState.accepted.name,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Container(
                              height: 35.h,
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 700),
                                  width: dimension.w,
                                  height: dimension.h,
                                  child: Image.asset(
                                    "assets/icons/done.png",
                                    height: 30.h,
                                    width: 30.w,
                                  )),
                            ),
                          ),
                          Text(
                            "Congrats!\nNow you can login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp,
                                color: Colors.white),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                PreferenceUtils.clear();
                                pushReplacement(
                                    context,
                                    LoginScreen(
                                      type: cubit.type,
                                    ));
                              },
                              child: Text("Login")),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Visibility(
                      visible: cubit.requestState == RequestState.rejected.name,
                      child: Column(
                        children: [
                          Container(
                            height: 35.h,
                            child: AnimatedContainer(
                                duration: Duration(milliseconds: 700),
                                width: dimension.w,
                                height: dimension.h,
                                //padding: EdgeInsets.all(15.sp),
                                child: Image.asset(
                                  "assets/images/rejected.png",
                                  height: 30.h,
                                  width: 30.w,
                                )),
                          ),
                          Text(
                            "Sorry!\nYour registration request is rejected",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
