import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TestResultAppBar extends StatelessWidget {
  const TestResultAppBar({super.key, required this.name});
final String name;
  @override
  Widget build(BuildContext context) {
    return  Container(
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
              Text("Test Results",style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
              Text(name,style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.white
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
