import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/style/colors/colors.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({super.key, required this.text, required this.image});
final String text;
final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.pink[100],
          child: Image.asset(image
            ,height: 7.h,
            width: 7.w,),
        ),
        SizedBox(height: 1.h,),
        Text(text,style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.sp
            ,color: darkBlueColor
        ),)
      ],
    );
  }
}

