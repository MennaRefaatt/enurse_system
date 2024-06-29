import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/features/nurse/medical_history/manager/medical_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MedicalHistoryWidget extends StatefulWidget {
  const MedicalHistoryWidget({
    super.key,
    required this.cubit,
  });
  final MedicalHistoryCubit cubit;

  @override
  State<MedicalHistoryWidget> createState() => _MedicalHistoryWidgetState();
}

class _MedicalHistoryWidgetState extends State<MedicalHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalHistoryCubit, MedicalHistoryState>(
        builder: (context, state) {
      if (state is GetMedicalHistoryLoadingState) {
        return CircularProgressIndicator(
          color: lightPurpleColor,
        );
      } else {
        return widget.cubit.medicalHistoryModel.isNotEmpty
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.cubit.medicalHistoryModel.length,
                itemBuilder: (context, index) {
                  return Container(
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
                        ]),
                    child: Container(
                      padding: EdgeInsets.all(15.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Disease: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              ),
                              Text(
                                widget.cubit.medicalHistoryModel[index].disease,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Date of illness: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              ),
                              Text(
                                widget.cubit.medicalHistoryModel[index]
                                    .dateOfIllness,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Treated or not: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              ),
                              Text(
                                widget.cubit.medicalHistoryModel[index]
                                    .treatedOrNOt,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Medications: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              ),
                              Flexible(
                                child: Text(
                                  widget.cubit.medicalHistoryModel[index].medications,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : Text(
                "No Medical History is entered yet",
                style: TextStyle(color: lightPurpleColor, fontSize: 18.sp),
              );
      }
    });
  }
}
