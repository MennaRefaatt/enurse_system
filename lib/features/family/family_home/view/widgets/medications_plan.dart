import 'package:enurse_system/features/family/family_home/manager/family_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return CircularProgressIndicator();
      }
      else{
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.cubit.medicationModel.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.cubit.medicationModel[index].name,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              widget.cubit.medicationModel[index].start,
                              style:
                              TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: 53,
                            ),
                            Text(
                              widget.cubit.medicationModel[index].end,
                              style:
                              TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              widget.cubit.medicationModel[index].dosage,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        endIndent: 15,
                        indent: 15,
                        color: Color(0XFFE0E9F4),
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    });
  }
}