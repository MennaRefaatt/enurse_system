import 'package:enurse_system/features/authentication/register/manager/register_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DoctorAndNurseForm extends StatefulWidget {
  const DoctorAndNurseForm({super.key, required this.cubit});
final RegisterCubit cubit;
  @override
  State<DoctorAndNurseForm> createState() => _DoctorAndNurseFormState();
}

class _DoctorAndNurseFormState extends State<DoctorAndNurseForm> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Specialization', style: TextStyle(
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
            controller: widget.cubit.specializationController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return "write your specialization ";
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

        Text('Healthcare Institution', style: TextStyle(
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
            controller: widget.cubit.healthcareInstituteController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return "write your healthcare Institute";
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
