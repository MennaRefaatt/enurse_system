import 'package:enurse_system/features/nurse/ehr/manager/ehrscreen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';

class MedicationsWidget extends StatefulWidget {
  const MedicationsWidget({super.key, required this.cubit, required this.patientId});
  final EhrScreenCubit cubit;
 final String patientId;
  @override
  State<MedicationsWidget> createState() => _MedicationsWidgetState();
}

class _MedicationsWidgetState extends State<MedicationsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EhrScreenCubit,EhrscreenState>(builder: (context,state){
      if(state is EhrscreenFailureState){
        return CircularProgressIndicator(
          color: lightPurpleColor,
        );
      }else{
        return widget.cubit.medicationModel.isNotEmpty ?
         SizedBox(
          width: double.infinity,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.cubit.medicationModel.length,
              itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.all(15.sp),
                  padding: EdgeInsets.all(15.sp),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius:
                      BorderRadius.circular(20.sp),
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
                          widget.cubit.medicationModel[index].name,
                          style: TextStyle(
                            color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15.sp),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(15.sp)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Dosage: ",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                Text(widget.cubit.medicationModel[index].dosage)
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Start: ",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                Text(widget.cubit.medicationModel[index].start)
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "End: ",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                Text(widget.cubit.medicationModel[index].end)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        )
            : Text(
          "No Medications are entered yet",
          style: TextStyle(color: lightPurpleColor, fontSize: 15.sp),
        );
      }

    });
  }
}