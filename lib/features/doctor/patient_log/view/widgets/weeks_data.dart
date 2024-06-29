import 'package:enurse_system/features/doctor/patient_log/manager/patient_log_cubit.dart';
import 'package:enurse_system/features/doctor/patient_log/view/widgets/medications.dart';
import 'package:enurse_system/features/doctor/patient_log/view/widgets/weekly_report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WeeksData extends StatefulWidget {
  const WeeksData({super.key, required this.cubit});
  final  PatientLogCubit cubit;
  @override
  State<WeeksData> createState() => _WeeksDataState();
}

class _WeeksDataState extends State<WeeksData> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Medications",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp),
          ),
          Medications(cubit: widget.cubit,),
          WeeklyReport(),
        ],
      ),
    );
  }
}
