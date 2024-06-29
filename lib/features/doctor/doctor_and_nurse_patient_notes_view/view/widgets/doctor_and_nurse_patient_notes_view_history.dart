import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/utils/snack_bar_app.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../manager/doctor_and_nurse_patient_notes_view_cubit.dart';

class DoctorPatientNotesViewHistory extends StatefulWidget {
  const DoctorPatientNotesViewHistory(
      {super.key,
      required this.doctorAndNursePatientNotesViewCubit,
      required this.patientId, required this.type});
  final DoctorAndNursePatientNotesViewCubit doctorAndNursePatientNotesViewCubit;
  final String patientId;
  final String type;
  @override
  State<DoctorPatientNotesViewHistory> createState() =>
      _DoctorPatientNotesViewHistory();
}

class _DoctorPatientNotesViewHistory
    extends State<DoctorPatientNotesViewHistory> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorAndNursePatientNotesViewCubit,
        DoctorAndNursePatientNotesViewState>(builder: (context, state) {
      if (state is GetDoctorAndNursePatientNotesViewLoadingState) {
        return CircularProgressIndicator(
          color: lightPurpleColor,
        );
      } else {
        return widget.doctorAndNursePatientNotesViewCubit.notes.isNotEmpty ?
          ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.doctorAndNursePatientNotesViewCubit.notes.length,
          itemBuilder: (context, index) {
            return Slidable(
              startActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    Visibility(
                      visible: widget.type == "1" ,
                      child: SlidableAction(
                        borderRadius: BorderRadius.circular(20.sp),
                        padding: EdgeInsets.all(10.sp),
                        onPressed: (context) {
                          awesomeDialog(message: "Are you sure to delete this note?", index:index, );
                        },
                        backgroundColor: Colors.red[900]!,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ),
                  ]),
              child: Container(
                margin: EdgeInsets.all(15.sp),
                padding: EdgeInsets.all(15.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
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
                      alignment: Alignment.topRight,
                      children: [
                        MyTextFormField(
                          showPrefix: false,
                          enabled: false,
                          maxLines: 10,
                          minLines: 5,
                          filled: false,
                          validators: (value) {
                            if (value!.isEmpty) {
                              return 'please enter notes';
                            }
                            return null;
                          },
                          controller: widget.doctorAndNursePatientNotesViewCubit
                              .displayContentController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          title: widget.doctorAndNursePatientNotesViewCubit
                              .notes[index].date,
                          hint: widget.doctorAndNursePatientNotesViewCubit
                              .notes[index].content,
                          isPassword: false,
                          prefixIcon: Icons.edit,
                        ),
                        Visibility(
                          visible: widget.type== "1",
                          child: IconButton(onPressed: (){
                            awesomeDialog(message: "Are you sure to delete this note?", index:index, );
                          }, icon: Icon(Icons.delete,
                            color: Colors.red[900],)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
            );
          },
        )
      : Center(
        child: Text(
        "No Notes are entered yet",
        style: TextStyle(color: lightPurpleColor, fontSize: 18.sp),
          ),
      );
      }
    });
  }
  void awesomeDialog({required String message,required int index}) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        animType: AnimType.rightSlide,
        btnCancelColor: Colors.red[900],
        desc: message,
        btnCancelOnPress: () {},
        btnOkOnPress:() {
          widget.doctorAndNursePatientNotesViewCubit.deleteNotes(widget.doctorAndNursePatientNotesViewCubit.notes[index]);
          snackBar(context, "deleted successfully", lightPurpleColor);
        }
    ).show();
  }
}
