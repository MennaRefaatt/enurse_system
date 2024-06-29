import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/features/nurse/nurse_home/manager/nurse_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../shared/my_shared.dart';
import '../../../../../shared/my_shared_keys.dart';
import '../../../../doctor/doctor_and_nurse_profile/view/page/doctor_and_nurse_profile.dart';
import '../../../create_patient_account/view/create_patient_screen.dart';
import '../widgets/nurse_home_widget.dart';

class NHomeScreen extends StatefulWidget {
  NHomeScreen({super.key, required this.type});

  final String type;

  @override
  State<NHomeScreen> createState() => _NHomeScreenState();
}

class _NHomeScreenState extends State<NHomeScreen> {
  final cubit = NurseHomeCubit();
  @override
  void initState() {
    cubit.getPatients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<NurseHomeCubit, NurseHomeState>(
          listener: (context, state) {},
          child: Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              backgroundColor: lightPurpleColor,
              onPressed: () {
                push(context, CreatePatientAccountScreen(type: "2"));
              },
              child: Text(
                "+",
                style: TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.w400),
              ),
            ),
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18.sp),
                  decoration: BoxDecoration(
                      color: lightPurpleColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.sp),
                          bottomLeft: Radius.circular(15.sp))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "Nurse Home",
                            style: TextStyle(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'Nurse/ ${PreferenceUtils.getString(PrefKeys.name)}',
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          push(context, DAndNProfile());
                        },
                        child: PreferenceUtils.getString(PrefKeys.image).isEmpty
                            ? CircleAvatar(
                            radius: 25.sp,
                            child: SvgPicture.asset(
                              "assets/icons/profile.svg",
                              height: 3.h,
                              width: 10.w,
                            ))
                            : CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${PreferenceUtils.getString(PrefKeys.image)}"),
                          radius: 25.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15.sp),
                  padding: EdgeInsets.all(3.sp),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Patients ",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                            NurseHomeWidget(cubit: cubit)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
