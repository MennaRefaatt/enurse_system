import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/requestState/view/pending_screen.dart';
import 'package:enurse_system/core/widgets/app_text_field.dart';
import 'package:enurse_system/features/authentication/register/requestState.dart';
import 'package:enurse_system/features/authentication/register/view/page/register.dart';
import 'package:enurse_system/features/doctor/doctor_home/view/page/doctor_home.dart';
import 'package:enurse_system/features/family/family_home/view/page/family_home.dart';
import 'package:enurse_system/features/patient/patient_home/view/page/patient_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../../../admin/admin_main_screen/view/main_screen.dart';
import '../../../../nurse/nurse_home/view/page/nurse_home.dart';
import '../../../reset_password/view/page/forget_password.dart';
import '../../manager/login_cubit.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key, required this.type});
  final String type;
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool obscureText = true;
  final emailController = TextEditingController();
  var passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final cubit = LoginCubit();
  @override
  void initState() {
    super.initState();
    safePrint("=====================> ${widget.type}");
    emailController.text;
    passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => cubit,
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) => onStateChange(state),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  controller: emailController,
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
                  filled: true,
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
                  controller: passwordController,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  title: 'Password',
                  prefixIcon: Icons.lock_outline,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgetPassword()));
                    },
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: lightPurpleColor),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                SizedBox(
                  width: double.infinity,
                  height: 30.sp,
                  child: ElevatedButton(
                    onPressed: () => login(),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.sp)),
                      backgroundColor: lightPurpleColor,
                    ),
                    child: const Text('Log In',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Visibility(
                  visible: widget.type != "2" && widget.type != "5",
                  child: Column(
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            push(
                                context,
                                Register(
                                  type: widget.type,
                                ));
                          },
                          child: Text.rich(TextSpan(children: [
                            TextSpan(text: "Don't have account ?"),
                            TextSpan(
                                text: "  Register",
                                style: TextStyle(
                                    color: lightPurpleColor,
                                    fontWeight: FontWeight.bold))
                          ])),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "________________",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'OR',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 17.sp),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "________________",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/email-svgrepo-com.svg",
                            semanticsLabel: 'email',
                            height: 5.h,
                            width: 10.w,
                          ),
                          SvgPicture.asset(
                            "assets/icons/google-svgrepo-com.svg",
                            semanticsLabel: 'google',
                            height: 5.h,
                            width: 10.w,
                          ),
                          SvgPicture.asset(
                            "assets/icons/facebook-svgrepo-com.svg",
                            semanticsLabel: 'facebook',
                            height: 5.h,
                            width: 10.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void login() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    String email = emailController.text;
    String password = passwordController.text;
    cubit.login(email: email, password: password);
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

  void displayToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  onStateChange(LoginState state) {
    if (state is LoginLoadingState) {
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
    } else if (state is LoginSuccessState) {
      if(state.requestState == RequestState.pending.name){
        pushReplacement(context, PendingScreen());
      }
     else if (state.type == "0") {
        push(context, DoctorHome());
      }
      else if (state.type == "1") {
        push(context, NHomeScreen(type: '2',));
      }
      else  if (state.type == "2") {
       push(context, PatientHome());
      }
      else  if (state.type == "3") {
       push(context, FamilyHome());
      }
      if (state.type == "5") {
       push(context, AdminMainScreen());
      }

    } else if (state is LoginFailureState) {
      awesomeDialog(state.errorMessage);
      //displayToast( state.errorMessage);
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
