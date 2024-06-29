import 'package:enurse_system/features/doctor/patient_log/manager/patient_log_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';

class Medications extends StatefulWidget {
  const Medications({super.key, required this.cubit});
  final PatientLogCubit cubit;

  @override
  State<Medications> createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientLogCubit, PatientLogState>(
        builder: (context, state) {
      if (state is GetMedicationsLoadingState) {
        return CircularProgressIndicator();
      } else {
        return widget.cubit.medicationsModel.isNotEmpty ?
        Expanded(
          child: ListView.builder(
            //physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.cubit.medicationsModel.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(15.sp),
                padding: EdgeInsets.all(15.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  color: greyColor,
                  boxShadow: [
                    BoxShadow(
                      color: greyColor.withOpacity(0.5),
                      blurRadius: 7,
                      spreadRadius: 1,
                      offset: const Offset(0, 10), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25.sp,
                          backgroundColor: Colors.white,
                        ),
                        Icon(Icons.medication_liquid),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      widget.cubit.medicationsModel[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Dosage: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17.sp),
                        ),
                        Text(
                          widget.cubit.medicationsModel[index].dosage,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Start: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17.sp),
                        ),
                        Text(widget.cubit.medicationsModel[index].start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w300),),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "End: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17.sp),
                        ),
                        Text(widget.cubit.medicationsModel[index].end,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        )
            : Text(
          "No Medications are entered yet",
          style: TextStyle(color: lightPurpleColor, fontSize: 15.sp),
        );
      }
    });
  }
}
