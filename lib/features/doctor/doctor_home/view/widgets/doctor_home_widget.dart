import 'package:enurse_system/features/doctor/doctor_home/manager/doctor_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../../doctor_patient_view/view/page/doctor_patient_view.dart';

class DoctorHomeWidget extends StatefulWidget {
  const DoctorHomeWidget({
    super.key,
    required this.cubit, required this.type,
  });

  final DoctorHomeCubit cubit;
  final String type;

  @override
  State<DoctorHomeWidget> createState() => _DoctorHomeWidgetState();
}

class _DoctorHomeWidgetState extends State<DoctorHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorHomeCubit, DoctorHomeState>(
        builder: (context, state) {
      if (state is DoctorHomeLoadingState) {
        return CircularProgressIndicator(
          color: lightPurpleColor,
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Patients ",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),

            widget.cubit.patientDataModel.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.cubit.patientDataModel.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(15.sp),
                        onTap: () => push(
                            context,
                            DoctorPatientView(
                              name: widget.cubit.patientDataModel[index].name,
                              patientId:
                                  widget.cubit.patientDataModel[index].id,
                              patientProblem: widget.cubit.patientDataModel[index].patientProblem, type: widget.type,
                            )),
                        child: Container(
                            margin: EdgeInsets.only(bottom: 15.sp),
                            padding: EdgeInsets.all(15.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.sp),
                              color: greyColor,
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
                                  child: Text(
                                    widget.cubit.patientDataModel[index].name,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width: 26.w,
                                  child: ElevatedButton(
                                    onPressed: () => push(
                                        context,
                                        DoctorPatientView(
                                          name: widget.cubit
                                              .patientDataModel[index].name,
                                          patientId: widget
                                              .cubit.patientDataModel[index].id,
                                          patientProblem: widget.cubit.patientDataModel[index].patientProblem, type: widget .type,
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
                      );
                    },
                  )
                : Image.asset(
                    "assets/images/notFound.png",
                    height: 40.h,
                    fit: BoxFit.fitHeight,
                    width: 100.w,
                  ),
            SizedBox(
              height: 3.h,
            )
          ],
        );
      }
    });
  }
}
