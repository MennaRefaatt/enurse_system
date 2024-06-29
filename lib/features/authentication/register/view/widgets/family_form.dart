import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../manager/register_cubit.dart';

class FamilyForm extends StatefulWidget {
  const FamilyForm({super.key, required this.cubit});
final RegisterCubit cubit;
  @override
  State<FamilyForm> createState() => _FamilyFormState();
}

class _FamilyFormState extends State<FamilyForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('KinShip', style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold),),
        SizedBox(
          height: 1.h,
        ),
        SizedBox(
          height: 10.h,
          width: 200.w,
          child: TextFormField(
            controller: widget.cubit.kinShipController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return "write the kinship";
              }
              return null;
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0.sp),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.2.sp,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.2.sp,
                ),
                borderRadius: BorderRadius.circular(15.sp),
              ),
            ),
          ),
        ),

        Text('Patient Id', style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold),),
        SizedBox(
          height: 1.h,
        ),
        SizedBox(
          height: 10.h,
          width: 200.w,
          child: TextFormField(
            controller: widget.cubit.patientIdController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return "write Patient Id";
              }
              return null;
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0.sp),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.2.sp,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.2.sp,
                ),
                borderRadius: BorderRadius.circular(15.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
