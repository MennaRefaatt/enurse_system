import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/doctor/doctor_and_nurse_patient_notes_view/view/page/doctor_and_nurse_patient_notes_view.dart';
import 'package:enurse_system/features/nurse/ehr/view/page/EhrScreen.dart';
import 'package:enurse_system/features/nurse/patient_information_screen/manager/patient_information_cubit.dart';
import 'package:enurse_system/features/nurse/vital_Signs/view/page/vital_signs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/style/colors/colors.dart';
import '../manager/patient_information_state.dart';

class PatentInformationScreen extends StatefulWidget {
  PatentInformationScreen(
      {super.key,
      required this.docID,
      required this.name,
      required this.patientProblem,
      required this.type});

  final String docID;
  final String name;
  final String patientProblem;
  final String type;

  @override
  State<PatentInformationScreen> createState() =>
      _PatentInformationScreenState();
}

class _PatentInformationScreenState extends State<PatentInformationScreen> {
  final cubit = PatientInformationCubit();
  final _fireStore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseService firebaseService = FirebaseService();

  @override
  void initState() {
    cubit.getOnTheLoad();
    cubit.getDailyReport(patientId: widget.docID);
    cubit.name = widget.name;
    cubit.patientProblem = widget.patientProblem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<PatientInformationCubit, PatientInformationState>(
        listener: (context, state) {},
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: StreamBuilder<DocumentSnapshot<Object>>(
                stream:
                    _fireStore.collection('users').doc(user?.uid).snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return snapshot.hasData
                      ? Column(
                          children: [
                            PatientInformationAppbar(widget.name),
                            Container(
                              padding: EdgeInsets.all(15.sp),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Patient Problem",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      widget.patientProblem,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[700]),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5.sp),
                                      padding: EdgeInsets.all(10.sp),
                                      decoration: BoxDecoration(
                                        color: greyColor.withOpacity(.5),
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.stacked_bar_chart,
                                                color: lightPurpleColor,
                                              ),
                                              Text(
                                                "Vital Signs",
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: lightPurpleColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              vital_text(
                                                  stream: firebaseService
                                                      .getTemperatureStream(),
                                                  color: Color(0XFFFE5775),
                                                  title: "Temperature"),
                                              vital_text(
                                                  stream: firebaseService
                                                      .getPulseStream(),
                                                  color: Color(0XFFF3A53F),
                                                  title: "Pulse"),
                                              vital_text(
                                                  stream: firebaseService
                                                      .getOxygenStream(),
                                                  color: Color(0XFF8CB9BD),
                                                  title: "Oxygen")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              ImageIcon(AssetImage(
                                                  "assets/icons/chart_icon.png")),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                "View Vital Signs",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 35.w,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              VitalSignsPage(
                                                                name:
                                                                    widget.name,
                                                                id: widget
                                                                    .docID,
                                                              )));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.sp),
                                                  ),
                                                  backgroundColor: Colors.white,
                                                ),
                                                child: Text('GO',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Patient Records",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    InkWell(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                        onTap: () {
                                          safePrint("id" + widget.docID);
                                          push(
                                              context,
                                              EhrScreen(
                                                name: widget.name,
                                                patientId: widget.docID,
                                                type: widget.type,
                                              ));
                                        },
                                        child: PatientRecord(
                                            "Electronic Health Record", () {
                                          push(
                                              context,
                                              EhrScreen(
                                                name: widget.name,
                                                patientId: widget.docID,
                                                type: widget.type,
                                              ));
                                        })),
                                    PatientRecord("Daily Report", () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.sp)),
                                          backgroundColor: greyColor,
                                          scrollable: true,
                                          actions: <Widget>[
                                            cubit.dailyReport.isNotEmpty
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("Daily Report",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 23.sp)),
                                                      SizedBox(
                                                        height: 50.h,
                                                        width: 70.w,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: cubit
                                                              .dailyReport
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Container(
                                                              margin: EdgeInsets
                                                                  .all(10.sp),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15
                                                                          .sp),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.sp)),
                                                              child: Text(
                                                                cubit
                                                                    .dailyReport[
                                                                        index]
                                                                    .content,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Text(
                                                    "no daily report entered yet",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20.sp),
                                                  ),
                                          ],
                                        ),
                                      );
                                    }),
                                    InkWell(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                        onTap: () {
                                          safePrint("id" + widget.docID);
                                          push(
                                              context,
                                              DoctorAndNursePatientNotesView(
                                                patientId: widget.docID,
                                                type: widget.type,
                                              ));
                                        },
                                        child:
                                            PatientRecord("Patient Notes", () {
                                          push(
                                              context,
                                              DoctorAndNursePatientNotesView(
                                                patientId: widget.docID,
                                                type: widget.type,
                                              ));
                                        })),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(
                          color: lightPurpleColor,
                        ));
                }),
          ),
        ),
      ),
    );
  }

  Widget vital_text({
    required Stream<int> stream,
    required Color color,
    required String title,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            width: 25.w,
            height: 20.h,
            child: StreamBuilder<int>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: lightPurpleColor,
                    ),
                  );
                }

                var value = snapshot.data!;

                return Row(
                  children: [
                    Container(
                      height: 13.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          value.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25.sp,
                              color: color),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
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
                recordType,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            SizedBox(
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
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ],
        ));
  }

  Widget PatientInformationAppbar(String patientName) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
          color: lightPurpleColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.sp),
              bottomLeft: Radius.circular(15.sp))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4.h,
          ),
          Text(
            "Patient Information",
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

class FirebaseService {
  final databaseReference = FirebaseDatabase.instance.ref();

  Stream<int> getTemperatureStream() {
    final vitalSignsRef = databaseReference.child('vitalSigns');
    return vitalSignsRef.onValue.map((event) {
      final snapshot = event.snapshot;
      if (snapshot.value is String) {
        final values = snapshot.value as String;
        final splitValues =
            values.split(',').map((e) => int.tryParse(e) ?? 0).toList();
        return splitValues[0]; // Temperature value
      } else {
        return 0; // Default value in case of error
      }
    });
  }

  Stream<int> getPulseStream() {
    final vitalSignsRef = databaseReference.child('vitalSigns');
    return vitalSignsRef.onValue.map((event) {
      final snapshot = event.snapshot;
      if (snapshot.value is String) {
        final values = snapshot.value as String;
        final splitValues =
            values.split(',').map((e) => int.tryParse(e) ?? 0).toList();
        return splitValues[1]; // Pulse value
      } else {
        return 0; // Default value in case of error
      }
    });
  }

  Stream<int> getOxygenStream() {
    final vitalSignsRef = databaseReference.child('vitalSigns');
    return vitalSignsRef.onValue.map((event) {
      final snapshot = event.snapshot;
      if (snapshot.value is String) {
        final values = snapshot.value as String;
        final splitValues =
            values.split(',').map((e) => int.tryParse(e) ?? 0).toList();
        return splitValues[2]; // Oxygen value
      } else {
        return 0; // Default value in case of error
      }
    });
  }
}
