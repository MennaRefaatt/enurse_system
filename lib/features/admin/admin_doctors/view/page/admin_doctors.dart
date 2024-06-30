import 'package:enurse_system/features/admin/admin_doctors/view/widgets/admin_doctor_app_bar.dart';
import 'package:enurse_system/features/admin/admin_doctors/view/widgets/doctors_list.dart';
import 'package:enurse_system/features/admin/admin_doctors/view/widgets/doctors_register_request_list..dart';
import 'package:enurse_system/features/admin/manager/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AdminDoctors extends StatefulWidget {
  const AdminDoctors({super.key,});

  @override
  State<AdminDoctors> createState() => _AdminDoctorsState();
}

class _AdminDoctorsState extends State<AdminDoctors> {
  final cubit = AdminCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getRequestedData(type: "0"),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AdminDoctorsAppBar(),
            DoctorsList(cubit: cubit,),
            Divider(
              height: 1.h,
              thickness: 5.sp,
            ),
            DoctorsRegisterRequestList(cubit: cubit,),
            SizedBox(height: 7.h,)

          ],


        ),
      ),
    );
  }
}
