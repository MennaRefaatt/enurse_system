import 'package:enurse_system/features/admin/admin_nurse/view/widgets/admin_nurses_app_bar.dart';
import 'package:enurse_system/features/admin/admin_nurse/view/widgets/nurses_list.dart';
import 'package:enurse_system/features/admin/admin_nurse/view/widgets/nurses_register_requests_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../manager/admin_cubit.dart';

class AdminNurses extends StatefulWidget {
  const AdminNurses({super.key,});


  @override
  State<AdminNurses> createState() => _AdminNursesState();
}

class _AdminNursesState extends State<AdminNurses> {
  final cubit = AdminCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>cubit..getRequestedData(type: "1") ,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AdminNursesAppBar(),
            Container(
              margin: EdgeInsets.all(3.sp),
              padding: EdgeInsets.all(3.sp),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NursesList(
                      cubit: cubit,
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 1.h,
              thickness: 5.sp,
            ),
            NursesRegisterRequestsList(cubit: cubit,),
            SizedBox(height: 7.h,)

          ],
        ),
      ),
    );
  }
}