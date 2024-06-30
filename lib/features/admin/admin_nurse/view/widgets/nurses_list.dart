import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/admin/personal_Info/view/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/utils/snack_bar_app.dart';
import '../../../manager/admin_cubit.dart';

class NursesList extends StatefulWidget {
  NursesList({
    super.key,
    required this.cubit,
  });

  final AdminCubit cubit;

  @override
  State<NursesList> createState() => _NursesListState();
}

class _NursesListState extends State<NursesList> {
  @override
  void initState() {
    widget.cubit.getNurses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(builder: (context, state) {
      if (state is AdminNurseLoadingState) {
        return const CircularProgressIndicator(
          color: lightPurpleColor,
        );
      }
      else
      {
        return widget.cubit.nurseListModel.isNotEmpty ?
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 20.sp, left: 10.sp, right: 10.sp),
              child: Row(
                children: [
                  const ImageIcon(AssetImage("assets/icons/adminIcon.png")),
                  Text(
                    "  Nurses ",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.cubit.nurseListModel.length,
                itemBuilder: (context,index){
                  final nurses = widget.cubit.nurseListModel[index];
                  return Padding(
                    padding:  EdgeInsets.all(12.sp),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.sp,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          nurses.name,
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => PersonalInfo(
                                            docId: nurses.id,
                                            name: nurses.name,
                                            phone: nurses.phone,
                                            specialization: nurses.specialization,
                                            healthcareInstitute:nurses.healthcareInstitute,
                                            SSN: nurses.ssn,
                                            age: nurses.age,
                                            email:nurses.email)));
                              },
                              child: const ImageIcon(AssetImage(
                                  "assets/icons/AdminProfileIcon.png")),
                            ),
                            SizedBox(
                              width:5.w,
                            ),
                            InkWell(
                              onTap: () => awesomeDialog(message: 'Are you sure you want to delete this nurse?', index: index),
                              child: const ImageIcon(
                                AssetImage(
                                    "assets/icons/adminRemoveIcon.png"),
                                color: Colors.red,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                })

          ],
        )
            : Text("no nurses are registered yet",
          style: TextStyle(color: lightPurpleColor, fontSize: 18.sp),);
      }
    });
  }

  void awesomeDialog({required String message,required int index}) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        animType: AnimType.rightSlide,
        btnCancelColor: Colors.red[900],

        // title: message,
        desc: message,
        btnCancelOnPress: () {},
        btnOkOnPress:() async{
          widget.cubit.deleteNurse(widget.cubit.nurseListModel[index]);
          snackBar(context, "deleted successfully", lightPurpleColor);
        }
    ).show();
  }
}