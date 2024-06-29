import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/admin/personal_Info/view/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../manager/admin_cubit.dart';

class DoctorsList extends StatefulWidget {
  DoctorsList({
    super.key,
    required this.cubit,
  });

  final AdminCubit cubit;

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  @override
  void initState() {
    widget.cubit.getDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(builder: (context, state) {
      if (state is AdminDoctorLoadingState) {
        return CircularProgressIndicator(
          color: lightPurpleColor,
        );
      } else {
        return widget.cubit.doctorListModel.isNotEmpty ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 20.sp, left: 10.sp, right: 10.sp),
              child: Row(
                children: [
                  ImageIcon(AssetImage("assets/icons/adminIcon.png")),
                  Text(
                    "  Doctors ",
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
                itemCount: widget.cubit.doctorListModel.length,
                itemBuilder: (context,index){
                  final doctors = widget.cubit.doctorListModel[index];
                  return Padding(
                    padding:  EdgeInsets.all(10.sp),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.sp,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          doctors.name,
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => PersonalInfo(
                                            docId: doctors.id,
                                            name: doctors.name,
                                            phone: doctors.phone,
                                            specialization:
                                            doctors.specialization,
                                            healthcareInstitute:doctors.healthcareInstitute,
                                            SSN: doctors.ssn,
                                            age: doctors.age,
                                            email:doctors.email))
                                );
                              },
                              child: ImageIcon(AssetImage(
                                  "assets/icons/AdminProfileIcon.png")),
                            ),
                            SizedBox(
                              width:5.w,
                            ),
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(doctors.id)
                                    .delete()
                                    .then(
                                      (doc) =>
                                      safePrint("Document deleted"),
                                  onError: (e) => safePrint(
                                      "Error updating document $e"),
                                );
                              },
                              child: ImageIcon(
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
            : Text("no doctors are registered", style: TextStyle(color: lightPurpleColor, fontSize: 18.sp),);
      }
    });
  }
}