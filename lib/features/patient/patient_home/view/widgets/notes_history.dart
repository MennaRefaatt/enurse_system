import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/features/patient/patient_home/manager/patient_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/widgets/app_text_field.dart';

class NotesHistory extends StatefulWidget {
  const NotesHistory({super.key, required this.patientHomeCubit});
final PatientHomeCubit patientHomeCubit;
  @override
  State<NotesHistory> createState() => _NotesHistoryState();
}

class _NotesHistoryState extends State<NotesHistory> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientHomeCubit, PatientHomeState>(
        builder: (context, state) {
      if(state is GetPatientHomeLoadingState) {
        return CircularProgressIndicator(
          color: lightPurpleColor,
        );
      } else {
        return widget.patientHomeCubit.notes.isNotEmpty ?
          Container(
          margin: EdgeInsets.all(15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Notes History", style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.patientHomeCubit.notes.length,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      MyTextFormField(
                        showPrefix: false,
                        enabled: false,
                        maxLines: 10,
                        minLines: 5,
                        filled: true,
                        validators: (value) {
                          if (value!.isEmpty) {
                            return 'please enter notes';
                          }
                          return null;
                        },
                        controller: widget.patientHomeCubit.displayContentController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        title: "",
                        hint: widget.patientHomeCubit.notes[index].content,
                        isPassword: false,
                        prefixIcon: Icons.edit,
                      ),
                      Text(widget.patientHomeCubit.notes[index].date),

                    ],
                  );
                },),
            ],
          ),

        )
            : Text("no notes yet",
            style: TextStyle(color: lightPurpleColor, fontSize: 18.sp),);
      }
        }
    );
  }
}
