import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/features/patient/patient_home/manager/patient_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/utils/snack_bar_app.dart';
import '../../../../../core/widgets/app_text_field.dart';

class PatientNotes extends StatefulWidget {
  const PatientNotes({super.key, required this.patientHomeCubit});
  final PatientHomeCubit patientHomeCubit;
  @override
  State<PatientNotes> createState() => _PatientNotesState();
}

class _PatientNotesState extends State<PatientNotes> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.sp),
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: lightPurpleColor.withOpacity(0.2),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextFormField(
              showPrefix: false,
              maxLength: 200,
              maxLines: 20,
              minLines: 10,
              filled: false,
              textColor: lightPurpleColor,
              validators: (value) {
                if (value!.isEmpty) {
                  return 'please enter notes';
                }
                return null;
              },
              controller: widget.patientHomeCubit.contentController,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
              title: 'Notes',
              hint: 'Write your notes...',
              isPassword: false,
              prefixIcon: Icons.edit,
            ),
            SizedBox(
              height: 2.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    widget.patientHomeCubit.addNewNote();
                    snackBar(context, "Added", lightPurpleColor);
                    /*
                        if (widget.patientHomeCubit.notes.isEmpty) {
                          snackBar(
                              context, "error",
                              Colors.red);
                        } else {
                          widget.patientHomeCubit.addNewNote();
                        }

                         */
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Text('Save',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
