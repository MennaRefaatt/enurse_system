import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/features/family/family_home/manager/family_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MedicationsPlanWidget extends StatefulWidget {
  const MedicationsPlanWidget({super.key, required this.cubit});
  final FamilyHomeCubit cubit;

  @override
  State<MedicationsPlanWidget> createState() => _MedicationsPlanWidgetState();
}

class _MedicationsPlanWidgetState extends State<MedicationsPlanWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FamilyHomeCubit,FamilyHomeState>(builder: (context,state){
      if(state is FamilyHomeLoadingState){
        return const CircularProgressIndicator(
          color: lightPurpleColor,
        );
      }
      else{
        return SizedBox(
          height: 50.h,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.cubit.medicationModel.length,
              itemBuilder: (context,index){
                return Padding(
                  padding:  EdgeInsets.all(8.0.sp),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0.sp),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.cubit.medicationModel[index].name,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                            ),

                            Expanded(
                              child: Text(
                                widget.cubit.medicationModel[index].start.substring(0,5),
                                maxLines: 1,
                                style:
                                const TextStyle(fontSize: 18),
                              ),
                            ),

                            Expanded(
                              child: Text(
                                widget.cubit.medicationModel[index].end.substring(0,5),
                                maxLines: 1,
                                style:
                                const TextStyle(fontSize: 18),
                              ),
                            ),
                          Expanded(
                            child: Text(
                              widget.cubit.medicationModel[index].dosage,
                              maxLines: 1,

                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                                    ],
                                  ),
                                ),
                      const Divider(
                        endIndent: 15,
                        indent: 15,
                        color: Color(0XFFE0E9F4),
                      ),
                    ],
                  ),
                );
              }),
        );
      }
    });
  }
}