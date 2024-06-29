import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VitalSignsAppBar extends StatefulWidget {
  const VitalSignsAppBar({super.key, required this.patientName});
final String patientName;
  @override
  State<VitalSignsAppBar> createState() => _VitalSignsAppBarState();
}

class _VitalSignsAppBarState extends State<VitalSignsAppBar> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 18.h,
      width: double.infinity,
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
          color: lightPurpleColor,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15.sp),bottomLeft: Radius.circular(15.sp))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h,),
              Text("Vital Signs",style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),          Text(
                widget.patientName,
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
