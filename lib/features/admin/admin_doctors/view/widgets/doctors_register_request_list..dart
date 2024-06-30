import 'package:enurse_system/core/send_notify.dart';
import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/admin/manager/admin_cubit.dart';
import 'package:enurse_system/features/admin/widgets/request_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DoctorsRegisterRequestList extends StatefulWidget {
  const DoctorsRegisterRequestList({super.key, required this.cubit});
  final AdminCubit cubit;

  @override
  State<DoctorsRegisterRequestList> createState() =>
      _DoctorsRegisterRequestListState();
}

class _DoctorsRegisterRequestListState
    extends State<DoctorsRegisterRequestList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15.sp),
        child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Doctors Requests",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
                  ),
                  BlocBuilder<AdminCubit, AdminState>(
                    builder: (context, state) {
                      if (state is GetRequestStateLoading) {
                        return const CircularProgressIndicator(
                          color: lightPurpleColor,
                        );
                      } else if ( widget.cubit.requestedDataModel.isNotEmpty) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.cubit.requestedDataModel.length,
                          itemBuilder: (context, index) {
                            return RequestItem(
                                name:
                                    widget.cubit.requestedDataModel[index].name,
                                image: widget
                                    .cubit.requestedDataModel[index].image,
                                onAccept: () {
                                  safePrint("-------------------------------");
                                  safePrint(
                                      "id =================>${widget.cubit.requestedDataModel[index].id}");
                                  safePrint("-------------------------------");
                                  setState(() {
                                    widget.cubit
                                        .changeRequest(
                                      id: widget
                                          .cubit.requestedDataModel[index].id,
                                      accepted: true,
                                      type: "0",
                                    )
                                        .then((value) {
                                      sendNotification(
                                          id: widget.cubit
                                              .requestedDataModel[index].id,
                                          body: 'dcd');
                                    });
                                  });
                                },
                                onReject: () {
                                  widget.cubit.changeRequest(
                                    id: widget
                                        .cubit.requestedDataModel[index].id,
                                    accepted: false,
                                    type: "0",
                                  );
                                });
                          },
                        );
                      } else if ( widget.cubit.requestedDataModel.isEmpty) {
                        return Center(
                          child:  Text("no doctors are requested yet", style: TextStyle(color: lightPurpleColor, fontSize: 18.sp),)
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  )
                ],
              )
    );
  }
}
