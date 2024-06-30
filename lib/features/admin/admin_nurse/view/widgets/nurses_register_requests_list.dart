import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../manager/admin_cubit.dart';
import '../../../widgets/request_item.dart';

class NursesRegisterRequestsList extends StatefulWidget {
  const NursesRegisterRequestsList({
    super.key,
    required this.cubit,
  });

  final AdminCubit cubit;

  @override
  State<NursesRegisterRequestsList> createState() =>
      _NursesRegisterRequestsListState();
}

class _NursesRegisterRequestsListState
    extends State<NursesRegisterRequestsList> {
  @override
  void initState() {
    super.initState();
    widget.cubit.getRequestedData(type: "1");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        return Container(
            margin: EdgeInsets.all(15.sp),
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nurses Requests",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20.sp),
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
                                    name: widget
                                        .cubit.requestedDataModel[index].name,
                                    image: widget
                                        .cubit.requestedDataModel[index].image,
                                    onAccept: () {
                                      setState(() {
                                        widget.cubit
                                            .changeRequest(
                                          id: widget.cubit
                                              .requestedDataModel[index].id,
                                          accepted: true,
                                          type: "1",
                                        )
                                            .then((value) {
                                          widget.cubit.requestedDataModel
                                              .removeAt(index);
                                        });
                                      });
                                    },
                                    onReject: () {
                                      widget.cubit.changeRequest(
                                        id: widget
                                            .cubit.requestedDataModel[index].id,
                                        accepted: false,
                                        type: "1",
                                      );
                                    });
                              },
                            );
                          } else if ( widget.cubit.requestedDataModel.isEmpty) {
                            return Center(
                                child: Text(
                              "no requests yet",
                              style: TextStyle(color: lightPurpleColor, fontSize: 18.sp),
                            ));
                            } else {
                            return const SizedBox();
                            }
                          }
                      ),
                ])
        );
      },
    );
  }
}
