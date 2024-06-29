import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/features/onBoarding/onBoarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/style/colors/colors.dart';
import '../../../../../shared/my_shared.dart';
import '../../../../../shared/my_shared_keys.dart';

class PatientHomeAppBar extends StatefulWidget {
  const PatientHomeAppBar({super.key});

  @override
  State<PatientHomeAppBar> createState() => _PatientHomeAppBarState();
}

class _PatientHomeAppBarState extends State<PatientHomeAppBar> {
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
                "Patient Home",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '${PreferenceUtils.getString(PrefKeys.name)}',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ],
          ),
          IconButton(
              onPressed: () {
                awesomeDialog("Are you sure to Log Out");
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.red[900],
                size: 25.sp,
              )),
        ],
      ),
    );
  }

  void awesomeDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      barrierColor: Colors.white54,
      btnCancelColor: Colors.grey,
      btnOkColor: Colors.red[900],
      btnOkText: "Yes",
      dialogBackgroundColor: Colors.white70,
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
