import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enurse_system/features/family/family_home/manager/family_home_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../../../../shared/my_shared.dart';
import '../../../../../shared/my_shared_keys.dart';
import '../../../../onBoarding/onBoarding.dart';
import '../widgets/medications_plan.dart';

class FamilyHome extends StatefulWidget {
  const FamilyHome({super.key});

  @override
  State<FamilyHome> createState() => _FamilyHomeState();
}

class _FamilyHomeState extends State<FamilyHome> {
  final cubit = FamilyHomeCubit();

  @override
  void initState() {
    cubit.getMedications();
    cubit.getDailyReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<FamilyHomeCubit, FamilyHomeState>(
        listener: (context, state) {
          // if(state is FamilyHomeInitial){
          //   cubit.getOnTheLoad();
          // }
        },
        child: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18.sp),
                  decoration: BoxDecoration(
                      color: lightPurpleColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.sp),
                          bottomLeft: Radius.circular(15.sp))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "Family Home",
                            style: TextStyle(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'family member/ ${PreferenceUtils.getString(PrefKeys.name)}',
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            awesomeDialog("Are you sure to Log Out");
                          },
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.red[900],
                            size: 25.sp,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      PatientRecord("Daily Report", () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(32.0))),
                            backgroundColor: lightPurpleColor,
                            scrollable: true,
                            actions: <Widget>[
                              Form(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Daily Report",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 23.sp)),
                                    ListView.builder(
                                      itemCount: cubit.dailyReport.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          color: Colors.white,
                                          height: 40.sp,
                                          child: Text(
                                            cubit.dailyReport[index].content,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                      width: double.infinity,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/MedicationPlanIcon.png",
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Medication Plan",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              "Start",
                              style: TextStyle(
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              "End",
                              style: TextStyle(
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              "Dosage",
                              style: TextStyle(
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        endIndent: 15,
                        indent: 15,
                        color: Color(0XFFE0E9F4),
                      ),
                      Container(
                        height: 45.h,
                        margin: EdgeInsets.all(5.sp),
                        padding: EdgeInsets.all(3.sp),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [MedicationsPlanWidget(cubit: cubit)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void awesomeDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: message,
      //desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () => setState(() {
        FirebaseAuth.instance.signOut().then((value) async {
          await PreferenceUtils.clear();
          pushReplacement(context, OnBoarding());
        });
      }),
    ).show();
  }

  Widget PatientRecord(String recordType, void Function()? onPressed) {
    return Container(
        margin: EdgeInsets.only(bottom: 15.sp),
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: greyColor.withOpacity(.5),
          boxShadow: [
            BoxShadow(
              color: greyColor.withOpacity(0.2),
              blurRadius: 7,
              spreadRadius: 1,
              offset: const Offset(0, 10), // Shadow position
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                recordType,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 3.h,
              width: 19.w,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Text('view',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ],
        ));
  }
}
