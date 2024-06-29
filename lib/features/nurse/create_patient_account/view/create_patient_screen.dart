import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/features/nurse/create_patient_account/manager/create_patient_account_cubit.dart';
import 'package:enurse_system/features/nurse/nurse_home/view/page/nurse_home.dart';
import 'package:enurse_system/shared/my_shared.dart';
import 'package:enurse_system/shared/my_shared_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/style/colors/colors.dart';
import '../../../../core/widgets/app_drop_down.dart';
import '../../../../core/widgets/app_text_field.dart';

class CreatePatientAccountScreen extends StatefulWidget {
  const CreatePatientAccountScreen({super.key, required this.type});

  final String type;

  @override
  State<CreatePatientAccountScreen> createState() =>
      _CreatePatientAccountScreenState();
}

class _CreatePatientAccountScreenState
    extends State<CreatePatientAccountScreen> {
  bool obscureText1 = true;
  bool obscureText2 = true;
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final cubit = CreatePatientAccountCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<CreatePatientAccountCubit, CreatePatientAccountState>(
        listener: (BuildContext context, CreatePatientAccountState state) {
          onStateChange(state);
        },
        child: Scaffold(
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Appbar(),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: EdgeInsets.all(15.sp),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextFormField(
                          filled: true,
                          validators: (value) {
                            if (value!.isEmpty) {
                              return 'please enter Patient Name';
                            }
                            return null;
                          },
                          controller: cubit.nameController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          title: 'Name',
                          hint: 'Name',
                          isPassword: false,
                          prefixIcon: Icons.edit,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MyTextFormField(
                          filled: true,
                          validators: (value) {
                            if (value!.isEmpty) {
                              return 'please enter patient email';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                          hint: 'Email',
                          controller: cubit.emailController,
                          isPassword: false,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          title: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MyTextFormField(
                          validators: (value) {
                            if (value!.isEmpty) {
                              return 'please enter  password';
                            }
                            if (value.length < 6) {
                              return 'Invalid password';
                            }
                            return null;
                          },
                          hint: 'Password',
                          controller: cubit.passwordController,
                          isPassword: true,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.visiblePassword,
                          title: 'Password',
                          filled: true,
                          prefixIcon: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MyTextFormField(
                          validators: (value) {
                            if (value!.isEmpty) {
                              return 'please enter  password';
                            }
                            if (value.length < 6) {
                              return 'Invalid password';
                            }
                            if (cubit.passwordController.text != value) {
                              return "password doesn't match";
                            }
                            return null;
                          },
                          hint: 'Password',
                          controller: cubit.passwordConfirmController,
                          isPassword: true,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.visiblePassword,
                          title: 'Password',
                          prefixIcon: Icons.lock_outline,
                          filled: true,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MyTextFormField(
                          validators: (value) {
                            if (value!.isEmpty) {
                              return 'please enter patient phone';
                            }
                            if (!value.contains('01')) {
                              return 'wrong phone';
                            }
                            if (value.length != 11) {
                              return 'length must be equal 11';
                            }
                            return null;
                          },
                          controller: cubit.mobileController,
                          maxLength: 11,
                          filled: true,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          title: 'Mobile',
                          hint: '',
                          isPassword: false,
                          prefixIcon: Icons.phone,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MyTextFormField(
                          filled: true,
                          validators: (value) {
                            if (value!.isEmpty) {
                              return 'please enter SSN';
                            }
                            if (value.length != 14) {
                              return 'length must be equal 14';
                            }
                            return null;
                          },
                          controller: cubit.SSNController,
                          maxLength: 14,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          title: 'SSN',
                          hint: '',
                          isPassword: false,
                          prefixIcon: Icons.numbers_outlined,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MyTextFormField(
                          filled: true,
                          validators: (value) {
                            if (value!.isEmpty) {
                              return 'please enter City Name';
                            }
                            return null;
                          },
                          controller: cubit.cityController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          title: 'City',
                          hint: 'City',
                          isPassword: false,
                          prefixIcon: Icons.edit,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MyTextFormField(
                          filled: true,
                          validators: (value) {
                            if (value!.isEmpty) {
                              return 'please enter patient problem';
                            }
                            return null;
                          },
                          controller: cubit.patientProblemController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          title: 'Patient Problem',
                          hint: 'Patient Problem',
                          isPassword: false,
                          prefixIcon: Icons.emergency_outlined,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 40.w,
                              child: MyTextFormField(
                                filled: true,
                                validators: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter Age';
                                  }
                                  return null;
                                },
                                maxLength: 2,
                                controller: cubit.ageController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.number,
                                title: 'Age',
                                hint: '',
                                isPassword: false,
                                prefixIcon: Icons.edit,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gender',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  DropDownTextFormField(
                                    hint: 'Gender',
                                    count: 2,
                                    controller: cubit.genderController,
                                    dropDownList: [
                                      DropDownValueModel(
                                          name: "Male", value: "Male"),
                                      DropDownValueModel(
                                          name: "Female", value: "Female"),
                                    ],
                                    enabled: false, filled: true,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 40.w,
                              child: MyTextFormField(
                                filled: true,
                                validators: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter room number';
                                  }
                                  return null;
                                },
                                maxLength: 3,
                                controller: cubit.roomNumberController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.number,
                                title: 'Room Number',
                                hint: '',
                                isPassword: false,
                                prefixIcon: Icons.room_outlined,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Entry Date",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  width: 40.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp)),
                                    child: TextFormField(
                                      controller: cubit.entryDateController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0.sp),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 0.2.sp,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        hintText: '',
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: 18.sp),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 0.2.sp,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a Entry date';
                                        }
                                        return null;
                                      },
                                      readOnly: true,
                                      onTap: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                        );
                                        if (date != null) {
                                          setState(() {
                                            cubit.entryDateController.text =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(date);
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.createAccount(type: widget.type);
                                PreferenceUtils.setString(PrefKeys.patientId, "id");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.sp)),
                              backgroundColor: lightPurpleColor,
                            ),
                            child: const Text(
                              'Add ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Appbar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25.sp),
      decoration: BoxDecoration(
          color: lightPurpleColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.sp),
              bottomLeft: Radius.circular(15.sp))),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          "Add Patient ",
          style: TextStyle(
              fontSize: 21.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }

  void awesomeDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      // title: message,
      desc: message,
      //btnCancelOnPress: () {},
      btnOkOnPress: () => Navigator.pop(context),
    ).show();
  }

  onStateChange(CreatePatientAccountState state) {
    if (state is CreatePatientAccountLoadingState) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.orange,
            backgroundColor: Colors.grey,
          ));
        },
      );
    } else if (state is CreatePatientAccountSuccessState) {
      push(
          context,
          NHomeScreen(
            type: widget.type,
          ));
    } else if (state is CreatePatientAccountFailureState) {
      awesomeDialog(state.errorMessage);
    }
  }
}
