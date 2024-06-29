import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/nurse/medical_history/manager/medical_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../../../../core/utils/snack_bar_app.dart';
import '../../../../../core/widgets/app_text_field.dart';

class AddMedicalHistory extends StatefulWidget {
  AddMedicalHistory({super.key, required this.cubit, required this.name, required this.patientId, required this.type});

  final MedicalHistoryCubit cubit;
  final String name;
  final String patientId;
  final String type;

  @override
  State<AddMedicalHistory> createState() => _AddMedicalHistoryState();
}

class _AddMedicalHistoryState extends State<AddMedicalHistory> {
  DateTime selectedDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2023, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.cubit.date =
            DateUtils.dateOnly(selectedDate).toString().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.cubit,
      child: BlocListener<MedicalHistoryCubit, MedicalHistoryState>(
        listener: (context, state) {
          if (state is AddMedicalHistorySuccessState) {
            pop(context);
            safePrint("object");
          }
          if (state is AddMedicalHistoryFailureState) {
            safePrint("object");

            showDialog(
              context: context,
              builder: (context) {
                return Text("error");
              },
            );
          }
        },
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(15.sp),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Medical History",
                        style: TextStyle(
                            color: lightPurpleColor,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyTextFormField(
                      filled: true,
                      validators: (value) {
                        if (value!.isEmpty) {
                          return 'please enter Disease Type';
                        }
                        return null;
                      },
                      controller: widget.cubit.diseaseController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      title: 'Disease Type',
                      hint: '',
                      isPassword: false,
                      prefixIcon: Icons.edit,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyTextFormField(
                      filled: true,
                      validators: (value) {
                        if (value!.isEmpty) {
                          return 'please enter treated ot not';
                        }
                        return null;
                      },
                      controller: widget.cubit.treatedOrNotController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      title: 'Treated Or Not Treated ',
                      hint: '',
                      isPassword: false,
                      prefixIcon: Icons.edit,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyTextFormField(
                      filled: true,
                      validators: (value) {
                        if (value!.isEmpty) {
                          return 'please enter medication';
                        }
                        return null;
                      },
                      controller: widget.cubit.medicationsController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      title: 'Medication',
                      hint: '',
                      isPassword: false,
                      prefixIcon: Icons.medical_services_outlined,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20.sp),
                      onTap: () => datePicker(context),
                      child: SizedBox(
                        width: 47.w,
                        child: MyTextFormField(
                          filled: true,
                          validators: (value) {
                            if (value!.isEmpty) {
                              return 'please enter date';
                            }
                            return null;
                          },
                          controller: widget.cubit.dateOfIllnessController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          title: 'Date of illness',
                          hint: '${selectedDate.toLocal()}'.split(' ')[0],
                          isPassword: false,
                          enabled: false,
                          prefixIcon: Icons.schedule,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          if (widget.cubit.date.isEmpty &&
                              !formKey.currentState!.validate()) {
                            snackBar(
                                context,
                                "Please fill all medical history data",
                                Colors.red[900]!);
                          } else {
                            SaveMedicalHistoryData();
                            snackBar(
                                context,
                                "Added",
                                lightPurpleColor);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp)),
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Done',
                          style:
                              TextStyle(color: lightPurpleColor, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void SaveMedicalHistoryData(){
    widget.cubit.saveMedicalHistoryData(patientId: widget.patientId, patientName: widget.name);

  }
}
