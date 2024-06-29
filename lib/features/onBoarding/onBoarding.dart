import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/style/colors/colors.dart';
import '../authentication/userType/view/page/users_types_screen.dart';
class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h,),
            Text("Welcome to \n   E-Nurse",
                style: TextStyle(
                  color: lightPurpleColor,
              fontSize:25.sp,
              fontWeight: FontWeight.w600,
            )),
            SizedBox(height: 5.h,),
            // Image.asset("assets/images/adminIcon.png"),
            Image.asset("assets/images/onBoarding.png"),

            Spacer(),
            SizedBox(
              height: 8.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => push(context, UsersTypesScreen()),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  backgroundColor:lightPurpleColor,
                ),
                child:  Text ('Get Started',
                    style: TextStyle(color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
            SizedBox(height: 10.h,),
          ],
        ),
      ),
    );
  }
}
