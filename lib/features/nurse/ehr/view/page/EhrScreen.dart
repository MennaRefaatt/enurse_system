import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/nurse/ehr/manager/ehrscreen_cubit.dart';
import 'package:enurse_system/features/nurse/rays/view/page/rays.dart';
import 'package:enurse_system/features/nurse/test_results/view/page/test_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../shared/my_shared.dart';
import '../../../../../shared/my_shared_keys.dart';
import '../../../allergies/view/page/allergies_screen.dart';
import '../../../medical_history/view/page/medical_history_screen.dart';
import '../widgets/medications_widget.dart';

class EhrScreen extends StatefulWidget {
  const EhrScreen({super.key, required this.name, required this.patientId, required this.type});
  final String name;
  final String patientId;
  final String type;
  @override
  State<EhrScreen> createState() => _EhrScreenState();
}

class _EhrScreenState extends State<EhrScreen> {
  final cubit = EhrScreenCubit();

  @override
  void initState() {
    cubit.getMedications(patientId: widget.patientId);
    cubit.name = widget.name;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<EhrScreenCubit, EhrscreenState>(
        listener: (context, state) {},
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  EHR_Appbar(widget.name),
                  Container(
                    padding: EdgeInsets.all(15.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            EHRType(
                                "assets/icons/TestResulticon.png", "Test Result",
                                () {
                                  safePrint("------"+PreferenceUtils.getString(PrefKeys.patientId));
                                  safePrint("------"+widget.patientId);

                                  push(
                                  context,
                                  TestResults(
                                    name: widget.name,
                                    patientId: widget.patientId,
                                    type: widget.type,
                                  ));
                            }),
                            EHRType("assets/icons/RayesIcon.png", "Rays", () {
                              safePrint("------"+PreferenceUtils.getString(PrefKeys.patientId));
                              safePrint("------"+widget.patientId);
                              push(
                                  context,
                                  Rays(
                                    name: widget.name,
                                    patientId: widget.patientId, type: widget.type,
                                  ));
                            })
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            EHRType("assets/icons/AllergiesIcon.png", "Allergies",
                                () {
                              push(context, AllergiesScreen(
                                name: widget.name,
                                id: widget.patientId,
                                type: widget.type,
                              ));
                            }),
                            EHRType("assets/icons/MedicalHistoryIcon.png",
                                "Medical History", () {
                             push(context, MedicalHistoryScreen(
                               name: widget.name,
                               patientId: widget.patientId,
                               type: widget.type,
                             ));
                            })
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(15.sp),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/medicationIcon.png",
                          height: 39,
                          width: 40,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "Medications",
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                        )
                      ],
                    ),
                  ),
                  MedicationsWidget(
                    cubit: cubit,
                    patientId: widget.patientId,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget EHRType(String Icon, String EHRName, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 15.h,
        width: 40.w,
        padding: EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color:greyColor.withOpacity(.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              (Icon),
              height: 7.h,
              width: 10.w,
            ),
            Text(
              EHRName,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget EHR_Appbar(String patientName) {
    return Container(
      padding: EdgeInsets.all(15.sp),
      width: double.infinity,
      decoration: BoxDecoration(
          color: lightPurpleColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.sp),
              bottomLeft: Radius.circular(15.sp))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 4.h,
          ),
          Text(
            "EHR",
            style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Text(
            patientName,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}

