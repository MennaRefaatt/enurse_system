import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/core/widgets/app_text_field.dart';
import 'package:enurse_system/features/admin/admin_main_screen/view/main_screen.dart';
import 'package:enurse_system/features/admin/admin_profile/manager/admin_profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../../../../shared/my_shared.dart';
import '../../../../../shared/my_shared_keys.dart';
import '../../../../onBoarding/onBoarding.dart';

class AdminProfileBody extends StatefulWidget {
  const AdminProfileBody({super.key});

  @override
  State<AdminProfileBody> createState() => _AdminProfileBodyState();
}

class _AdminProfileBodyState extends State<AdminProfileBody> {
  final cubit = AdminProfileCubit();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cubit.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<AdminProfileCubit, AdminProfileState>(
        listener: (context, state) {
        },
        child: Form(
          key: formKey,

          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              if (PreferenceUtils.getString(PrefKeys.image).isEmpty)
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      setState(() {
                        cubit.pickImage();
                      });
                    },
                    child: CircleAvatar(
                      radius: 30.sp,
                        child:SvgPicture.asset("assets/icons/profile.svg",height: 5.h,width: 10.w, )
                    ),
                  ),
                )
              else
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            PreferenceUtils.getString(PrefKeys.image)),
                        radius: 30.sp,
                      ),
                      Visibility(
                        visible: cubit.uploading,
                        child: const CircularProgressIndicator(
                          color: lightPurpleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextFormField(
                        hint: "Admin ID",
                        controller: cubit.adminIdController,
                        isPassword: false,
                        enabled: false,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        title: "Admin ID",
                        prefixIcon: Icons.perm_identity_sharp,
                        filled: false),
                    SizedBox(
                      height: 20,
                    ),

                    MyTextFormField(
                        hint: 'Name',
                        controller: cubit.nameController,
                        isPassword: false,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        title: 'Name',
                        prefixIcon: Icons.person_outline,
                        filled: false),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                      enabled: false,
                      hint: 'Email',
                      controller: cubit.emailController,
                      isPassword: false,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      title: 'Email',
                      prefixIcon: Icons.alternate_email,
                      filled: false,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50.w,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          saveUserData();
                          Future.delayed( Duration(seconds: 2), () {
                            displayToast("updated");

                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        backgroundColor: lightPurpleColor,
                      ),
                      child: Text('Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        awesomeDialog("Are you sure to Log Out");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        backgroundColor: Colors.red[900],
                      ),
                      child: Text('Log Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveUserData() async {
    safePrint('erroooor ');
    await cubit.saveUserData();
  }

  void awesomeDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      barrierColor: Colors.white54,
      btnCancelColor: Colors.grey,
      btnOkColor: Colors.red[900],
      btnOkText: "Yes",
      dialogBackgroundColor: Colors.white70,
      title: message,
      //desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () => setState(() {
        FirebaseAuth.instance.signOut().then((value) async {
          await PreferenceUtils.clear();
          pushReplacement(context, OnBoarding());
        });
      }),
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


  onStateChange(AdminProfileState state) {
    if (state is AdminProfileLoadingState) {
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
    } else if (state is AdminProfileSuccessState) {
      // push(context, LoginScreen(type: widget.type,));
    } else if (state is AdminProfileSuccessState) {
      pushReplacement(context, AdminMainScreen());
      pushReplacement(context, AdminMainScreen());
      // push(context, LoginScreen(type: widget.type,));
    } else if (state is AdminProfileFailureState) {
      awesomeDialog(state.errorMessage);
    }
  }
}
