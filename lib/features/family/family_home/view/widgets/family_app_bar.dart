import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../../../../shared/my_shared.dart';
import '../../../../onBoarding/onBoarding.dart';

class FamilyAppBar extends StatefulWidget {
  const FamilyAppBar({super.key});

  @override
  State<FamilyAppBar> createState() => _FamilyAppBarState();
}

class _FamilyAppBarState extends State<FamilyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25.sp),
      decoration: BoxDecoration(
          color: lightPurpleColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.sp),
              bottomLeft: Radius.circular(15.sp))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [

              Text(
                "Family Member Home",
                style: TextStyle(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(width: 4.w,),
              IconButton(
                onPressed: () {
                  awesomeDialog("Are you sure to Log Out");
                },
                icon: Icon(Icons.logout_rounded,color: Colors.black,size: 30,),

              ),
            ],
          ),
          Text(
            "Ahmed Mohamed Mahmoud",
            style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ],
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
}