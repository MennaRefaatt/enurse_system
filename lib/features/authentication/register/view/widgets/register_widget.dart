import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:enurse_system/features/requestState/view/pending_screen.dart';
import 'package:enurse_system/core/widgets/app_drop_down.dart';
import 'package:enurse_system/features/authentication/login/view/page/login_screen.dart';
import 'package:enurse_system/features/authentication/register/view/widgets/doctor_and_nurse_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../manager/register_cubit.dart';
import 'family_form.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key, required this.type});
  final String type;
  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  bool obscureText1 = true;
  bool obscureText2 = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final cubit = RegisterCubit();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => cubit,
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) => onStateChange(state),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                MyTextFormField(
                  filled: true,
                  validators: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your Name';
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
                      return 'please enter your email';
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
                      return 'please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Invalid password';
                    }
                    return null;
                  },
                  hint: 'Password',
                  controller: cubit.passController,
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
                      return 'please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Invalid password';
                    }
                    if (cubit.passController.text != value) {
                      return "password doesn't match";
                    }
                    return null;
                  },
                  hint: 'Password',
                  controller: cubit.confirmPasswordController,
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
                      return 'please enter your phone';
                    }
                    if (!value.contains('01')) {
                      return 'wrong phone';
                    }
                    if (value.length != 11) {
                      return 'length must be equal 11';
                    }
                    return null;
                  },
                  controller: cubit.phoneController,
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
                      return 'please enter your SSN';
                    }
                    if (value.length != 14) {
                      return 'length must be equal 14';
                    }
                    return null;
                  },
                  controller: cubit.ssnController,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MyTextFormField(
                        filled: true,
                        validators: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your Age';
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            count: 4,
                            controller: cubit.genderController,
                            dropDownList: [
                              DropDownValueModel(name: "Male", value: "Male"),
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
                Visibility(
                  visible: widget.type == "1" || widget.type == "0",
                  child: DoctorAndNurseForm(
                    cubit: cubit,
                  ),
                ),
                Visibility(
                    visible: widget.type == "3",
                    child: FamilyForm(
                      cubit: cubit,
                    )),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.createAccount(type: widget.type);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.sp)),
                      backgroundColor: lightPurpleColor,
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    'Already have account?',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: lightPurpleColor),
                    ),
                  )
                ]),
              ],
            ),
          ),
        ));
  }

  void awesomeDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      // title: message,
      desc: message,
      //btnCancelOnPress: () {},
      //btnOkOnPress: () {},
    ).show();
  }

  onStateChange(RegisterState state) {
    if (state is RegisterLoadingState) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(
            color: lightPurpleColor,
            backgroundColor: Colors.grey,
          ));
        },
      );
    } else if (state is RegisterSuccessState) {
      if (widget.type == "0" || widget.type == "1") {
        pushReplacement(context, PendingScreen());
      } else {
        push(
            context,
            LoginScreen(
              type: widget.type,
            ));
      }
    } else if (state is RegisterFailureState) {
      awesomeDialog(state.errorMessage);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
