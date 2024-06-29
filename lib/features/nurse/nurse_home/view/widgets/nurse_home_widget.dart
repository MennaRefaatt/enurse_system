import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/nurse/nurse_home/manager/nurse_home_cubit.dart';
import 'package:enurse_system/features/nurse/nurse_home/view/widgets/personal_patient_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/style/colors/colors.dart';
import '../../../patient_information_screen/page/patient_information_screen.dart';
import '../../../patient_personal_info/view/patien_personal_info_screen.dart';

class NurseHomeWidget extends StatefulWidget {
  const NurseHomeWidget({super.key, required this.cubit});

  final NurseHomeCubit cubit;

  @override
  State<NurseHomeWidget> createState() => _NurseHomeWidgetState();
}

class _NurseHomeWidgetState extends State<NurseHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NurseHomeCubit, NurseHomeState>(
        builder: (context, state) {
      if (state is NurseHomeLoadingState) {
        return Center(child: CircularProgressIndicator(
          color: lightPurpleColor,
        ));
      } else {
        return Column(
          children: [
            widget.cubit.patientDataModel.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.cubit.patientDataModel.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              borderRadius: BorderRadius.circular(15.sp),
                              padding: EdgeInsets.all(10.sp),
                              onPressed: (BuildContext context) async {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(
                                        widget.cubit.patientDataModel[index].id)
                                    .delete()
                                    .then(
                                      (doc) => safePrint("Document deleted"),
                                      onError: (e) =>
                                          safePrint("Error updating document $e"),
                                    );
                              },
                              backgroundColor: Colors.red[900]!,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                            SlidableAction(
                              borderRadius: BorderRadius.circular(15.sp),
                              padding: EdgeInsets.all(10.sp),
                              onPressed: (BuildContext context) {
                                push(
                                    context,
                                    PatientPersonalInfoScreen(
                                      docId: widget
                                          .cubit.patientDataModel[index].id,
                                      name: widget
                                          .cubit.patientDataModel[index].name,
                                      phone: widget
                                          .cubit.patientDataModel[index].phone,
                                      city: widget
                                          .cubit.patientDataModel[index].city,
                                      SSN: widget
                                          .cubit.patientDataModel[index].ssn,
                                      age: widget
                                          .cubit.patientDataModel[index].age,
                                      roomNumber: widget.cubit
                                          .patientDataModel[index].roomNumber,
                                      gender: widget.cubit.patientDataModel[index].gender,
                                    ));
                              },
                              backgroundColor: Color(0xFF21B7CA),
                              foregroundColor: Colors.white,
                              icon: Icons.info_outline,
                              label: 'Info',
                            ),
                            SlidableAction(
                              borderRadius: BorderRadius.circular(15.sp),
                              padding: EdgeInsets.all(10.sp),
                              onPressed: (BuildContext context) {
                                push(
                                    context,
                                    UpdatePersonalInfo(
                                      docId: widget
                                          .cubit.patientDataModel[index].id,
                                      oldName: widget
                                          .cubit.patientDataModel[index].name,
                                      oldPhone: widget
                                          .cubit.patientDataModel[index].phone,
                                      oldCity: widget
                                          .cubit.patientDataModel[index].city,
                                      oldSSN: widget
                                          .cubit.patientDataModel[index].ssn,
                                      oldAge: widget
                                          .cubit.patientDataModel[index].age,
                                      oldRoomNumber: widget.cubit
                                          .patientDataModel[index].roomNumber,
                                      oldGender: widget.cubit.patientDataModel[index].gender,
                                    ));
                              },
                              backgroundColor: Colors.deepOrangeAccent,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Update',
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            push(
                                context,
                                PatentInformationScreen(
                                  docID:
                                      widget.cubit.patientDataModel[index].id,
                                  name:
                                      widget.cubit.patientDataModel[index].name,
                                  patientProblem: widget.cubit
                                      .patientDataModel[index].patientProblem, type: '1',
                                ));
                          },
                          child: Container(
                              margin: EdgeInsets.only(bottom: 15.sp),
                              padding: EdgeInsets.all(15.sp),
                              width: double.infinity,
                              height: 10.h,
                              decoration: BoxDecoration(
                                color: greyColor,
                                borderRadius: BorderRadius.circular(20.sp),
                                boxShadow: [
                                  BoxShadow(
                                    color: greyColor.withOpacity(0.5),
                                    blurRadius: 7,
                                    spreadRadius: 1,
                                    offset:
                                        const Offset(0, 10), // Shadow position
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        widget
                                            .cubit.patientDataModel[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        widget.cubit.patientDataModel[index]
                                            .entryDate,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 26.w,
                                    child: ElevatedButton(
                                      onPressed: () => push(
                                          context,
                                          PatentInformationScreen(
                                            docID: widget.cubit
                                                .patientDataModel[index].id,
                                            name: widget.cubit
                                                .patientDataModel[index].name,
                                            patientProblem: widget
                                                .cubit
                                                .patientDataModel[index]
                                                .patientProblem,
                                            type: '1',
                                          )),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.sp),
                                        ),
                                        backgroundColor: Colors.white,
                                      ),
                                      child: Text('view',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    })
                : Image.asset(
                    "assets/images/notFound.png",
                    height: 40.h,
                    fit: BoxFit.fitHeight,
                    width: 100.w,
                  ),
            SizedBox(
              height: 3.h,
            ),
          ],
        );
      }
    });
  }
}
