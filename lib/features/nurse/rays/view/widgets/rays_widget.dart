import 'package:enurse_system/features/nurse/rays/manager/rays_cubit.dart';
import 'package:enurse_system/features/nurse/rays/view/page/ray_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';

class RaysWidget extends StatefulWidget {
  const RaysWidget({
    super.key,
    required this.cubit,
    required this.name, required this.patientId, required this.type,
  });
  final RaysCubit cubit;
  final String name;
  final String patientId;
  final String type ;

  @override
  State<RaysWidget> createState() => _RaysWidgetState();
}

class _RaysWidgetState extends State<RaysWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RaysCubit, RaysState>(
      builder: (context, state) {
        if (state is GetRaysLoadingState) {
          return CircularProgressIndicator(
            color: lightPurpleColor,
          );
        } else {
          return widget.cubit.raysModel.isNotEmpty ?
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.sp),
            child: ListView.builder(
                itemCount: widget.cubit.raysModel.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(20.sp),
                    onTap: () => push(
                        context,
                        RaysDetails(
                          cubit: widget.cubit,
                          index: index,
                          name: widget.name,
                          patientId:widget.patientId, type: widget.type,
                        )),
                    child: Container(
                        height: 50.h,
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
                              offset: const Offset(0, 10), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cubit.raysModel[index].title,
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Collected on: ",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Expanded(
                                  child: Text(
                                    widget.cubit.raysModel[index].date,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(15.sp),
                                      child: Image.network(widget
                                          .cubit.raysModel[index].images[0])),
                                ],
                              ),
                            ),
                          ],
                        )),
                  );
                }),
          )
              : Text(
            "No Rays are entered yet",
            style: TextStyle(color: lightPurpleColor, fontSize: 18.sp),
          );
        }
      },
    );
  }
}
