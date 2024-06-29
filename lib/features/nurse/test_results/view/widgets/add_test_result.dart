import 'dart:io';
import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/core/utils/snack_bar_app.dart';
import 'package:enurse_system/core/widgets/app_text_field.dart';
import 'package:enurse_system/features/nurse/test_results/manager/test_results_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../shared/my_shared.dart';
import '../../../../../shared/my_shared_keys.dart';

class AddTestResult extends StatefulWidget {
  AddTestResult({super.key, required this.patientId});

  final String patientId;

  @override
  State<AddTestResult> createState() => _AddTestResultState();
}

class _AddTestResultState extends State<AddTestResult> {
  @override
  void initState() {
    super.initState();
  }
  final cubit = TestResultsCubit();
  DateTime selectedDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2023, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        cubit.date =
            DateUtils.dateOnly(selectedDate).toString().substring(0, 10);
        cubit.dateController.text = cubit.date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<TestResultsCubit, TestResultsState>(
        listener: (context, state) {
          if (state is AddTestResultsSuccessState) {
            pop(context);
            safePrint("object");
          }

          if (state is AddTestResultsFailureState) {
            safePrint("object");

            showDialog(
              context: context,
              builder: (context) {
                return Text("error");
              },
            );
          }
        },
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(15.sp),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Test Result Data",
                        style: TextStyle(
                            color: lightPurpleColor,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyTextFormField(
                      filled: true,
                      validators: (value) {
                        if (value!.isEmpty) {
                          return 'please enter Test Result Name';
                        }
                        return null;
                      },
                      controller: cubit.nameController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      title: 'Test Result Name',
                      hint: '',
                      isPassword: false,
                      prefixIcon: Icons.edit,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20.sp),
                      onTap: () => datePicker(context),
                      child: SizedBox(
                        width: 47.w,
                        child: MyTextFormField(
                          filled: true,
                          validators: (value) {
                            if (value!.isEmpty) {
                              return 'please enter date';
                            }
                            return null;
                          },
                          controller: cubit.dateController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          title: 'Test Result Date',
                          hint: '${selectedDate.toLocal()}'.split(' ')[0],
                          isPassword: false,
                          enabled: false,
                          prefixIcon: Icons.schedule,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    cubit.files.isNotEmpty
                        ? BlocBuilder<TestResultsCubit, TestResultsState>(
                            builder: (context, state) {
                              return GridView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  children: List.generate(
                                      cubit.files.length, (index) {
                                    return Container(
                                        margin: EdgeInsets.all(10.sp),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                          child: Image.file(
                                            File(
                                              cubit.files[index].path,
                                            ),
                                            height: 10.h,
                                            width: 10.w,
                                          ),
                                        ));
                                  }));
                            },
                          )
                        : SizedBox(),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () async {
                            cubit.pickImage().then((value) => setState(() {}));

                          },
                          child: Text(
                            "Add Image",
                            style: TextStyle(
                                color: lightPurpleColor, fontSize: 20.sp),
                          )),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    BlocBuilder<TestResultsCubit, TestResultsState>(
                      builder: (context, state) {
                        if (state is AddTestResultsLoadingState) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: lightPurpleColor,
                            backgroundColor: Colors.white70,
                          ));
                        } else {
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {
                                if (cubit.files.isEmpty &&
                                    !formKey.currentState!.validate()) {
                                  snackBar(
                                      context,
                                      "Please fill all test result data",
                                      Colors.red[900]!);
                                } else {
                                  saveTestResultData();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                backgroundColor: Colors.white,
                              ),
                              child: const Text(
                                'Done',
                                style: TextStyle(
                                    color: lightPurpleColor, fontSize: 20),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveTestResultData() {
    cubit.saveTestResultData(patientId: widget.patientId);
  }
}
