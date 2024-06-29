import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/features/nurse/medical_history/manager/medical_history_cubit.dart';
import 'package:enurse_system/features/nurse/medical_history/view/widget/add_medical_history.dart';
import 'package:enurse_system/features/nurse/medical_history/view/widget/medical_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../shared/my_shared.dart';
import '../../../../../shared/my_shared_keys.dart';
import '../widget/medicalHistort_appBar.dart';

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key, required this.name, required this.type, required this.patientId,});
  final String name;
  final String patientId;
  final String type;


  @override
  State<MedicalHistoryScreen> createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  final cubit = MedicalHistoryCubit();

  @override
  void initState() {
    cubit.getMedicalHistory(patientId: widget.patientId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<MedicalHistoryCubit, MedicalHistoryState>(
        listener: (context, state) {},
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MedicalHistoryAppBar(patientName: widget.name,),
                MedicalHistoryWidget(
                  cubit: cubit,
                ),
                Visibility(
                  visible:PreferenceUtils.getString(PrefKeys.type) == "1",
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                         push(context, AddMedicalHistory(
                           cubit: cubit, name: widget.name, patientId: widget.patientId, type: widget.type,
                         ));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp)),
                          backgroundColor: lightPurpleColor,
                        ),
                        child:  Text(
                          'Add ',
                          style: TextStyle(color: Colors.white, fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}