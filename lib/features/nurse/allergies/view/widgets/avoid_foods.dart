import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/features/nurse/allergies/manager/allergies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AvoidFoodsWidget extends StatefulWidget {
  const AvoidFoodsWidget({super.key, required this.cubit});

  final AllergiesCubit cubit;

  @override
  State<AvoidFoodsWidget> createState() => _AvoidFoodsWidgetState();
}

class _AvoidFoodsWidgetState extends State<AvoidFoodsWidget> {
  final cubit = AllergiesCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllergiesCubit, AllergiesState>(
        builder: (context, state) {
          if (state is GetAllergiesLoadingState) {
            return CircularProgressIndicator(
              color: lightPurpleColor,
            );
          } else {
            return widget.cubit.allergiesModel.isNotEmpty ?
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.cubit.allergiesModel.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(10.sp),
                        child: Row(
                          children: [
                            Visibility(
                              visible: widget.cubit.allergiesModel[index].avoidFood.isNotEmpty ,
                              child: Text(
                                widget.cubit.allergiesModel[index].avoidFood,
                                style: TextStyle(
                                    fontSize: 19.sp, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.cubit.allergiesModel[index].avoidFood.isNotEmpty ,
                        child: Divider(
                          indent: 15.sp,
                          endIndent: 15.sp,
                        ),
                      ),
                    ],
                  );
                })
                : Text("no foods to avoid",style: TextStyle(fontSize: 20.sp),);
          }
        });
  }
}