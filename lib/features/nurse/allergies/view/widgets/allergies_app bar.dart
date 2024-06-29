import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/style/colors/colors.dart';

class AllergiesAppBar extends StatefulWidget {
  const AllergiesAppBar({super.key, required this.patientName});
  final String patientName;

  @override
  State<AllergiesAppBar> createState() => _AllergiesAppBarState();
}

class _AllergiesAppBarState extends State<AllergiesAppBar> {
  @override
  Widget build(BuildContext context) {
    return  Container(
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
          SizedBox(height: 4.h,),
          Text("Allergies",style: TextStyle(
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),),
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