import 'package:enurse_system/features/patient/patient_home/manager/patient_home_cubit.dart';
import 'package:enurse_system/features/patient/patient_home/view/widgets/emergency_and_help.dart';
import 'package:enurse_system/features/patient/patient_home/view/widgets/notes_history.dart';
import 'package:enurse_system/features/patient/patient_home/view/widgets/patient_home_app_bar.dart';
import 'package:enurse_system/features/patient/patient_home/view/widgets/patient_notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  final cubit = PatientHomeCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getNotes(),
    child: BlocListener<PatientHomeCubit, PatientHomeState>(
    listener: (context, state) {
    },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              PatientHomeAppBar(),
              PatientNotes(patientHomeCubit: cubit),
              Divider(
                thickness: 5.sp,
              ),
              EmergencyAndHelp(patientHomeCubit: cubit,),
              Divider(
                thickness: 5.sp,
              ),
              NotesHistory(patientHomeCubit: cubit,),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
