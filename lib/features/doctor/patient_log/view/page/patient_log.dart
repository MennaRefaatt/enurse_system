import 'package:enurse_system/features/doctor/patient_log/manager/patient_log_cubit.dart';
import 'package:enurse_system/features/doctor/patient_log/view/widgets/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/patient_log_app_bar.dart';

class PatientLogScreen extends StatefulWidget {
  const PatientLogScreen({super.key, required this.name, required this.patientId});
final String name;
  final String patientId;

  @override
  State<PatientLogScreen> createState() => _PatientLogScreenState();
}

class _PatientLogScreenState extends State<PatientLogScreen> {
  final cubit=PatientLogCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => cubit..getMedications(patientId: widget.patientId),
        child: BlocListener<PatientLogCubit, PatientLogState>(
        listener: (context, state) {},
          child:   Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    PatientLogAppBar(name:widget.name,),
                    TabBarWidget(cubit: cubit,),
                  ],
                          ),
              ),
            ),

  ),
    );
  }
}
