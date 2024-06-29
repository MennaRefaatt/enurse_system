import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class MyTextFormField extends StatefulWidget {
  MyTextFormField({
    Key? key,
    required this.hint,
    this.borderRadius,
    this.margin,
    this.padding,
    this.isSearch = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.textColor = Colors.black,
    required this.controller,
    required this.isPassword,
    this.validators,
    required this.textInputAction,
    required this.textInputType,
    this.enabled =true,
    required this.title,
    this.showPrefix = true,
    required this.prefixIcon,
    required this.filled,
    this.maxLength=1000,
    this.color,
  }) : super(key: key);
  final int maxLength;
  final Color textColor;
  final bool isPassword;
  final int maxLines;
  final int minLines;
  final bool filled;
  final bool isSearch;
  final bool? enabled;
  final FormFieldValidator<dynamic>? validators;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String hint;
  final String title;
  final IconData prefixIcon;
  final bool showPrefix;
  final Color? color;

  BorderRadius? borderRadius;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.color
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,style: TextStyle(
              color:Colors.black,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold),),
          SizedBox(height: 2.h,),
          TextFormField(
            maxLength: widget.maxLength,
            maxLines:widget.maxLines ,
            minLines:widget.minLines ,
            enabled: widget.enabled,
            validator: widget.validators,
            obscureText: obscureText,
            controller: widget.controller,
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: widget.showPrefix == false ? null  : Icon(widget.prefixIcon,color: Colors.black,),
              suffixIcon: Visibility(
                visible: widget.isPassword,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                ),
              ),
              hintText: widget.hint,
              hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey
              ),
              focusColor: Colors.grey.shade200,
              fillColor: Colors.grey.shade200,
              filled: widget.filled,
              disabledBorder:OutlineInputBorder(

                borderSide:  BorderSide(color: Colors.grey.shade200, width: 2.0),
                borderRadius: BorderRadius.circular(13.0),
              ) ,
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.grey.shade200, width: 2.0),
                borderRadius: BorderRadius.circular(13.0),
              ),


              border: OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.grey.shade200, width: 2.0),
                borderRadius: BorderRadius.circular(13.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.grey.shade200, width: 2.0),
                borderRadius: BorderRadius.circular(13.0),
              ),

            ),


          ),
        ],
      ),
    );
  }
}