import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../widgets/register_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.type});
  final String type;
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            height: 15.h,
            width: double.infinity,
            padding: EdgeInsets.only(top: 30.sp, right: 25.sp, left: 15.sp),
            decoration: BoxDecoration(
                color: lightPurpleColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.sp),
                  bottomRight: Radius.circular(15.sp),
                )),
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: EdgeInsets.all(15.sp),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegisterWidget(
                  type: widget.type,
                ),
              ],
            ),
          )
        ])));
  }
}
