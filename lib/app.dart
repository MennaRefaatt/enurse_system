import 'package:enurse_system/features/requestState/view/pending_screen.dart';
import 'package:enurse_system/features/authentication/register/requestState.dart';
import 'package:enurse_system/features/doctor/doctor_home/view/page/doctor_home.dart';
import 'package:enurse_system/features/family/family_home/view/page/family_home.dart';
import 'package:enurse_system/features/nurse/nurse_home/view/page/nurse_home.dart';
import 'package:enurse_system/features/onBoarding/onBoarding.dart';
import 'package:enurse_system/features/patient/patient_home/view/page/patient_home.dart';
import 'package:enurse_system/shared/my_shared.dart';
import 'package:enurse_system/shared/my_shared_keys.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'features/admin/admin_main_screen/view/main_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          home: PreferenceUtils.getString(PrefKeys.userId).isEmpty
               ? const OnBoarding()
               : PreferenceUtils.getString(PrefKeys.type) == "0"
                   ? PreferenceUtils.getString(PrefKeys.requestState) ==
                           RequestState.pending.name
                       ? PendingScreen()
                       : const DoctorHome()
                   : PreferenceUtils.getString(PrefKeys.type) == "1"
                       ? PreferenceUtils.getString(PrefKeys.requestState) ==
                               RequestState.pending.name
                           ? PendingScreen()
                           : NHomeScreen(type: "1")
                       : PreferenceUtils.getString(PrefKeys.type) == "2"
                           ? const PatientHome()
                           : PreferenceUtils.getString(PrefKeys.type) == "3"
                               ? const FamilyHome()
                              : const AdminMainScreen()
                           );
    });
  }
}
