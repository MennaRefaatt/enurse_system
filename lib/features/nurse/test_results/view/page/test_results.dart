import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/features/nurse/test_results/manager/test_results_cubit.dart';
import 'package:enurse_system/features/nurse/test_results/view/widgets/add_test_result.dart';
import 'package:enurse_system/features/nurse/test_results/view/widgets/test_result_app_bar.dart';
import 'package:enurse_system/features/nurse/test_results/view/widgets/test_results_widget.dart';
import 'package:enurse_system/shared/my_shared.dart';
import 'package:enurse_system/shared/my_shared_keys.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/colors/colors.dart';


class TestResults extends StatelessWidget {
  TestResults(
      {super.key, required this.name, required this.patientId, required this.type});
  final String name;
  final String patientId;
final String type;
  final cubit = TestResultsCubit();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getTestResults(patientId: patientId),
      child: BlocListener<TestResultsCubit, TestResultsState>(
        listener: (context, state) {},
        child: Scaffold(
          floatingActionButton: Visibility(
            visible:PreferenceUtils.getString(PrefKeys.type) == "1",
            child: FloatingActionButton(
                child: Icon(Icons.add,color: Colors.white,),
                backgroundColor: lightPurpleColor,
                onPressed: () {
                  push(
                      context,
                      AddTestResult(
                        patientId: patientId,
                      ));
                }),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                TestResultAppBar(
                  name: name,
                ),

                TestResultsWidget(
                  patientId: patientId,
                  cubit: cubit,
                  name: name,
                  type: type,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
