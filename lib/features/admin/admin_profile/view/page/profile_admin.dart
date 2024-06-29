import 'package:enurse_system/features/admin/admin_profile/manager/admin_profile_cubit.dart';
import 'package:enurse_system/features/admin/admin_profile/view/widgets/App_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/profile_admin_body.dart';

class AdminProfile extends StatefulWidget {
  AdminProfile({super.key,});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final cubit = AdminProfileCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getUserData(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBarProfile(),
            AdminProfileBody(),
          ],
        ),
      ),
    );
  }
}
