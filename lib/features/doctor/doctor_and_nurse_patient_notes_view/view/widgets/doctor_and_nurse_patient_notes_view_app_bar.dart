import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/style/colors/colors.dart';

class DoctorAndNursePatientNotesViewAppBar extends StatefulWidget {
  const DoctorAndNursePatientNotesViewAppBar({super.key});

  @override
  State<DoctorAndNursePatientNotesViewAppBar> createState() =>
      _DoctorAndNursePatientNotesViewAppBar();
}

class _DoctorAndNursePatientNotesViewAppBar
    extends State<DoctorAndNursePatientNotesViewAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                "Patient Notes",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
