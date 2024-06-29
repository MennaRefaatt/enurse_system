import 'package:enurse_system/features/doctor/set_medication/manager/set_medication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/style/colors/colors.dart';
import '../widgets/set_medication_widget.dart';

class SetMedication extends StatefulWidget {
  const SetMedication({super.key, required this.patientId});
  final String patientId;

  @override
  State<SetMedication> createState() => _SetMedicationState();
}

class _SetMedicationState extends State<SetMedication> {
  final cubit = SetMedicationCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
     child: BlocListener<SetMedicationCubit, SetMedicationState>(
        listener: (context, state) {
          if(state is SetMedicationSuccessState){
           // return Navigator.pop(context);
          }
    },
    child:Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 11.h,
              width: double.infinity,
              padding: EdgeInsets.all(18.sp),
              decoration: BoxDecoration(
                  color: lightPurpleColor,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15.sp),bottomLeft: Radius.circular(15.sp))
              ),
              child:Text("Set Medication",style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
            ),
            Container(
              margin: EdgeInsets.all(15.sp),
              padding: EdgeInsets.all(15.sp),
              child:SingleChildScrollView(
                child: Column(
                  children: [
                    SetMedicationWidget(cubit: cubit, patientId: widget.patientId,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
        ),
    );
  }
}