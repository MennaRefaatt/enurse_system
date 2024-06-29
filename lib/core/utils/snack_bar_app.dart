import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

snackBar(BuildContext context,message,Color color){
  final snackBar = SnackBar(
    backgroundColor: color,
    content:  Center(child: Text(message,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),)),

  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}