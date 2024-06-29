import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enurse_system/features/doctor/doctor_patient_view/manager/doctor_patient_view_cubit.dart';
import 'package:enurse_system/features/doctor/doctor_patient_view/view/widgets/patient_records.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
class DoctorPatientView extends StatefulWidget {
  const DoctorPatientView(
      {super.key, required this.name, required this.patientId, required this.patientProblem, required this.type});

  final String name;
  final String patientId;
  final String patientProblem;
  final String type;

  @override
  State<DoctorPatientView> createState() => _DoctorPatientViewState();
}

class _DoctorPatientViewState extends State<DoctorPatientView> {
  final cubit = DoctorPatientViewCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<DoctorPatientViewCubit, DoctorPatientViewState>(
        listener: (context, state) => onStateChange(state),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18.sp),
                  decoration: BoxDecoration(
                      color: lightPurpleColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.sp),
                          bottomLeft: Radius.circular(15.sp))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "Patient Information",
                            style: TextStyle(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15.sp),
                  padding: EdgeInsets.all(15.sp),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PatientRecords(
                          doctorPatientViewCubit: cubit,
                          name: widget.name,
                          patientId: widget.patientId, patientProblem: widget.patientProblem, type: widget.type,
                        ),
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

  void awesomeDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      // title: message,
      desc: message,
      //btnCancelOnPress: () {},
      btnOkOnPress: () => Navigator.pop(context),
    ).show();
  }

  onStateChange(DoctorPatientViewState state) {
    if (state is DoctorPatientViewLoadingState) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.orange,
            backgroundColor: Colors.grey,
          ));
        },
      );
    } else if (state is DoctorPatientViewSuccessState) {
      cubit.contentController.clear();
      Navigator.pop(context);
    } else if (state is DoctorPatientViewFailureState) {
      awesomeDialog(state.errorMessage);
    }
  }
}
