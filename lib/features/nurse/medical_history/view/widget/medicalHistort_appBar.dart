import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/style/colors/colors.dart';

class MedicalHistoryAppBar extends StatefulWidget {
  const MedicalHistoryAppBar({super.key, required this.patientName});
  final String patientName;

  @override
  State<MedicalHistoryAppBar> createState() => _MedicalHistoryAppBarState();
}

class _MedicalHistoryAppBarState extends State<MedicalHistoryAppBar> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4.h,
          ),
          Text(
            "Medical History",
            style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Text(
            widget.patientName,
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