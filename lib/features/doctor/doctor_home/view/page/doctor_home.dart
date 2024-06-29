import 'package:enurse_system/features/doctor/doctor_and_nurse_profile/view/page/doctor_and_nurse_profile.dart';
import 'package:enurse_system/features/doctor/doctor_home/manager/doctor_home_cubit.dart';
import 'package:enurse_system/features/doctor/doctor_home/view/widgets/doctor_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../../../../shared/my_shared.dart';
import '../../../../../shared/my_shared_keys.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  final cubit = DoctorHomeCubit();

  @override
  void initState() {
    cubit.getPatients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => cubit,
        child: BlocListener<DoctorHomeCubit, DoctorHomeState>(
          listener: (context, state) {},
          child: Scaffold(
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
                            "Doctor Home",
                            style: TextStyle(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'Dr/ ${PreferenceUtils.getString(PrefKeys.name)}',
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
                  padding: EdgeInsets.all(15.sp),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        DoctorHomeWidget(
                          cubit: cubit, type: '0',
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
