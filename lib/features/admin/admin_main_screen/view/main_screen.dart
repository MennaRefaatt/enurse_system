import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/admin/admin_doctors/view/page/admin_doctors.dart';
import 'package:enurse_system/features/admin/admin_nurse/view/page/admin_nurses.dart';
import 'package:enurse_system/features/admin/admin_profile/view/page/profile_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => AdminMainScreenState();
}

class AdminMainScreenState extends State<AdminMainScreen> {
  int currentIndex = 0;
  List screens = <Widget>[
    AdminDoctors(),
    AdminNurses(),
    AdminProfile(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 8.h,
        width: 60.w,
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 25.sp),
        margin: EdgeInsets.only(right: 10.sp, bottom: 10.sp, left: 10.sp),
        decoration: BoxDecoration(
            color: lightPurpleColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20.sp)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(20.sp),
              onTap: () {
                setState(() {
                  currentIndex = 0;
                  safePrint(currentIndex);
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/user-md.svg"),
                  Visibility(
                      visible: currentIndex == 0,
                      child: Text(
                        "Doctors",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20.sp),
              onTap: () {
                setState(() {
                  currentIndex = 1;
                  safePrint(currentIndex);
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/user-nurse.svg"),
                  Visibility(
                      visible: currentIndex == 1,
                      child: Text(
                        "Nurses",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20.sp),
              onTap: () {
                setState(() {
                  currentIndex = 2;
                  safePrint(currentIndex);
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/profile.svg",
                    height: 3.h,
                    width: 5.w,
                  ),
                  Visibility(
                      visible: currentIndex == 2,
                      child: Text(
                        "Profile",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
