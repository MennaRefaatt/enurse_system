import 'package:enurse_system/features/doctor/doctor_and_nurse_patient_notes_view/manager/doctor_and_nurse_patient_notes_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/doctor_and_nurse_patient_notes_view_app_bar.dart';
import '../widgets/doctor_and_nurse_patient_notes_view_history.dart';

class DoctorAndNursePatientNotesView extends StatefulWidget {
  const DoctorAndNursePatientNotesView({super.key, required this.patientId, required this.type});
  final String patientId;
  final String type;
  @override
  State<DoctorAndNursePatientNotesView> createState() =>
      _DoctorAndNursePatientNotesViewState();
}

class _DoctorAndNursePatientNotesViewState
    extends State<DoctorAndNursePatientNotesView> {
  final cubit = DoctorAndNursePatientNotesViewCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getNotes(patientId: widget.patientId),
      child: BlocListener<DoctorAndNursePatientNotesViewCubit,
          DoctorAndNursePatientNotesViewState>(
        listener: (context, state) {},
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                DoctorAndNursePatientNotesViewAppBar(),
                DoctorPatientNotesViewHistory(
                    doctorAndNursePatientNotesViewCubit: cubit,
                    patientId: widget.patientId, type: widget.type,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
