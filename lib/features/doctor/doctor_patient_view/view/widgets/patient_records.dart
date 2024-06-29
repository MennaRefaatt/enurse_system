import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/doctor/doctor_and_nurse_patient_notes_view/view/page/doctor_and_nurse_patient_notes_view.dart';
import 'package:enurse_system/features/doctor/doctor_patient_view/manager/doctor_patient_view_cubit.dart';
import 'package:enurse_system/features/doctor/patient_log/view/page/patient_log.dart';
import 'package:enurse_system/features/nurse/ehr/view/page/EhrScreen.dart';
import 'package:enurse_system/features/nurse/patient_information_screen/page/patient_information_screen.dart';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../../../../core/utils/snack_bar_app.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../set_medication/view/page/set_medications.dart';

class PatientRecords extends StatefulWidget {
  const PatientRecords(
      {super.key,
      required this.doctorPatientViewCubit,
      required this.name,
      required this.patientId, required this.patientProblem, required this.type});

  final String name;
  final String patientId;
  final DoctorPatientViewCubit doctorPatientViewCubit;
  final String patientProblem;
  final String type;

  @override
  State<PatientRecords> createState() => _PatientRecordsState();
}

class _PatientRecordsState extends State<PatientRecords> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Patient Records",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        SizedBox(
          height: 3.h,
        ),
        InkWell(
          onTap: () => push(
              context,
              SetMedication(
                patientId: widget.patientId,
              )),
          borderRadius: BorderRadius.circular(15.sp),
          child: Container(
              margin: EdgeInsets.only(bottom: 15.sp),
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
                color: greyColor,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.5),
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
                      "Medications",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                    width: 25.w,
                    child: ElevatedButton(
                      onPressed: () => push(
                          context,
                          SetMedication(
                            patientId: widget.patientId,
                          )),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text('Set',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 2.h,
        ),
        InkWell(
          onTap: () {
            safePrint("id"+widget.patientId);
            push(
              context,
              EhrScreen(
                name: widget.name,
                patientId: widget.patientId, type: '1',
              ));
          },
          borderRadius: BorderRadius.circular(15.sp),
          child: Container(
              margin: EdgeInsets.only(bottom: 15.sp),
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
                color: greyColor,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.5),
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
                      "Electronic Health Record",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                    width: 25.w,
                    child: ElevatedButton(
                      onPressed: () {
                        push(
                            context,
                            EhrScreen(
                              name: widget.name,
                              patientId: widget.patientId, type: '0',
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text('View',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 2.h,
        ),
        InkWell(
          onTap: () => push(
              context,
              PatentInformationScreen(
                  docID: widget.patientId, name: widget.name,  patientProblem: widget.patientProblem, type: '0',)),
          borderRadius: BorderRadius.circular(15.sp),
          child: Container(
              margin: EdgeInsets.only(bottom: 15.sp),
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
                color: greyColor,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.5),
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
                      "Patient Information",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                    width: 25.w,
                    child: ElevatedButton(
                      onPressed: () => push(
                          context,
                          PatentInformationScreen(
                            docID: widget.patientId, name: widget.name,  patientProblem: widget.patientProblem, type: '0',)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text('View',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
            margin: EdgeInsets.only(bottom: 15.sp),
            padding: EdgeInsets.all(15.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              color: greyColor,
              boxShadow: [
                BoxShadow(
                  color: greyColor.withOpacity(0.5),
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
                    "Daily Report",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                  width: 25.w,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          shape:  RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20.sp)),
                          backgroundColor: greyColor,
                          scrollable: true,
                          actions: <Widget>[
                            Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Daily Report",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 23.sp)),
                                  MyTextFormField(
                                    showPrefix: false,
                                    maxLines: 20,
                                    minLines: 10,
                                    filled: false,
                                    validators: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter notes';
                                      }
                                      return null;
                                    },
                                    controller: widget.doctorPatientViewCubit
                                        .contentController,
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.text,
                                    title: '',
                                    hint: 'write your daily report',
                                    isPassword: false,
                                    prefixIcon: Icons.edit,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        widget.doctorPatientViewCubit
                                            .saveDailyNotes(
                                                patientId: widget.patientId);
                                        snackBar(
                                            context, "Added", lightPurpleColor);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                        ),
                                        backgroundColor: lightPurpleColor,
                                      ),
                                      child: Text('Save',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19.sp,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Text('Add',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ],
            )),
        SizedBox(
          height: 2.h,
        ),
        InkWell(
          onTap: () => push(
              context,
              PatientLogScreen(
                name: widget.name,
                patientId: widget.patientId,
              )),
          borderRadius: BorderRadius.circular(15.sp),
          child: Container(
              margin: EdgeInsets.only(bottom: 15.sp),
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
                color: greyColor,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.5),
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
                      "Patient Log",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                    width: 25.w,
                    child: ElevatedButton(
                      onPressed: () => push(
                          context,
                          PatientLogScreen(
                            name: widget.name,
                            patientId: widget.patientId,
                          )),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text('View',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 2.h,
        ),
        InkWell(
          onTap: () => push(
              context,
            DoctorAndNursePatientNotesView(patientId: widget.patientId, type: widget.type,),
             ),
          borderRadius: BorderRadius.circular(15.sp),
          child: Container(
              margin: EdgeInsets.only(bottom: 15.sp),
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
                color: greyColor,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.5),
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
                      "Patient Notes",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                    width: 25.w,
                    child: ElevatedButton(
                      onPressed: () => push(
                          context,
                          DoctorAndNursePatientNotesView(patientId: widget.patientId, type: widget.type,)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text('View',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
