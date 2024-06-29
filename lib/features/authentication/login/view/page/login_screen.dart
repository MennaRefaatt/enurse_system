import 'package:enurse_system/features/authentication/login/view/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.type, });
  final String type;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
                children: [
              Container(
                height:15.h,
                width: double.infinity,
                padding: EdgeInsets.only(top:30.sp,right:25.sp,left:15.sp),
                decoration:  BoxDecoration(
                    color: lightPurpleColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.sp),
                      bottomRight: Radius.circular(15.sp),
                    )),
                child: Text('Log In',style: TextStyle(color:Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold),),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding:  EdgeInsets.all(15.sp),
                color: Colors.white,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginWidget(type: widget.type,),
                ],
          ),
        )
    ])));
  }

}
