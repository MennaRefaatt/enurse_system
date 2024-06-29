import 'package:enurse_system/features/doctor/set_medication/manager/set_medication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/snack_bar_app.dart';
import '../../../../../core/widgets/app_text_field.dart';

class SetMedicationWidget extends StatefulWidget {
  const SetMedicationWidget(
      {super.key, required this.cubit, required this.patientId});
  final SetMedicationCubit cubit;
  final String patientId;
  @override
  State<SetMedicationWidget> createState() => _SetMedicationWidgetState();
}

class _SetMedicationWidgetState extends State<SetMedicationWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  Future<DateTime?> _startDate(BuildContext context) async {
    final DateTime? datePickerStart = await showDatePicker(
        context: context,
        initialDate: selectedStartDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2050));
    if (datePickerStart != null && datePickerStart != selectedStartDate) {
      setState(() {
        widget.cubit.startController.text =
            DateFormat('yyyy-MM-dd').format(datePickerStart);
        selectedStartDate = datePickerStart;
        widget.cubit.startDate = selectedStartDate;

      });
    }
    return datePickerStart;
  }

  Future<void> endDate(BuildContext context,DateTime input) async {
    final DateTime? datePickerEnd = await showDatePicker(
      context: context,
      initialDate:input.add(Duration(days: 1)),
      firstDate: input.add(Duration(days: 1)), // Set minimum end date
      lastDate: DateTime(2050),
    );
    if (datePickerEnd != null && datePickerEnd != selectedEndDate) {
      setState(() {
        widget.cubit.endController.text =
            DateFormat('yyyy-MM-dd').format(datePickerEnd);
        selectedEndDate = datePickerEnd;
        widget.cubit.endDate = selectedEndDate;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetMedicationCubit, SetMedicationState>(
        builder: (context, state) {
      if (state is SetMedicationLoadingState) {
        return Center(
          child: CircularProgressIndicator(
            color: lightPurpleColor,
          ),
        );
      } else {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextFormField(
                filled: true,
                validators: (value) {
                  if (value!.isEmpty) {
                    return 'please enter Name';
                  }
                  return null;
                },
                controller: widget.cubit.nameController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                title: 'Medication Name',
                hint: 'medication name',
                isPassword: false,
                prefixIcon: Icons.edit,
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20.sp),
                onTap: () => _startDate(context),
                child: SizedBox(
                  width: 50.w,
                  child: MyTextFormField(
                    filled: true,
                    validators: (value) {
                      if (value!.isEmpty) {
                        return 'please enter start';
                      }
                      return null;
                    },
                    controller: widget.cubit.startController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    textColor: Colors.black,
                    title: 'Starting Date',
                    hint: '${selectedStartDate.toLocal()}'.split(' ')[0],
                    isPassword: false,
                    enabled: false,
                    prefixIcon: Icons.schedule,
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20.sp),
                onTap: () {
                  if(widget.cubit.startController.text.isEmpty){
                    snackBar(context, "Choose Start Date First", Colors.red[900]!);
                  }
                  if(widget.cubit.startController.text.isNotEmpty){
                    String dateTime = widget.cubit.startController.text;
                    DateTime input = DateTime.parse(dateTime);
                    endDate(context,input);
                  }

                },
                child: SizedBox(
                  width: 50.w,
                  child: MyTextFormField(
                    filled: true,
                    validators: (value) {
                      if (value!.isEmpty) {
                        return 'please enter end';
                      }
                      return null;
                    },
                    controller: widget.cubit.endController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    title: 'Ending Date',
                    textColor: Colors.black,
                    hint: '${selectedEndDate.toLocal()}'.split(' ')[0],
                    isPassword: false,
                    enabled: false,
                    prefixIcon: Icons.calendar_month,
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),

              MyTextFormField(
                filled: true,
                validators: (value) {
                  if (value!.isEmpty) {
                    return 'please enter dosage';
                  }
                  if (!value.contains('per')) {
                    return 'must say per what';
                  }
                  return null;
                },
                controller: widget.cubit.dosageController,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.text,
                title: 'Dosage',
                hint: 'dosage per day',
                isPassword: false,
                prefixIcon: Icons.medication_liquid,
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.cubit.saveMedication(patientId: widget.patientId);
                      snackBar(context, "Added", lightPurpleColor);
                      widget.cubit.setMedicationModel.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.sp)),
                    backgroundColor: lightPurpleColor,
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
