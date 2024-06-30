import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/doctor/doctor_home/view/page/doctor_home.dart';
import 'package:enurse_system/features/nurse/nurse_home/view/page/nurse_home.dart';
import 'package:enurse_system/shared/my_shared.dart';
import 'package:enurse_system/shared/my_shared_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../onBoarding/onBoarding.dart';
import '../../manager/d_and_n_profile_cubit.dart';

class DAndNProfile extends StatefulWidget {
  const DAndNProfile({super.key});

  @override
  State<DAndNProfile> createState() => _DAndNProfileState();
}

class _DAndNProfileState extends State<DAndNProfile> {
  final cubit = DAndNProfileCubit();
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
      child: BlocListener<DAndNProfileCubit, DAndNProfileState>(
        listener: (context, state) => onStateChange(state),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(25.sp),
                  decoration: BoxDecoration(
                      color: lightPurpleColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.sp),
                          bottomLeft: Radius.circular(15.sp))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Profile",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 23.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15.sp),
                  padding: EdgeInsets.all(15.sp),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        profileInformation(),
                        SizedBox(
                          height: 2.h,
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
                                    Future.delayed(  const Duration(seconds: 2), () {
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
                      ],
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

  Widget profileInformation() {
    return BlocBuilder<DAndNProfileCubit, DAndNProfileState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      InkWell(
                        onTap: () => cubit.pickImage(),
                        child: CircleAvatar(
                          radius: 18.sp,
                          backgroundColor:greyColor,
                          child: Icon(
                            Icons.edit,
                            color: lightPurpleColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              MyTextFormField(
                  hint: 'Name',
                  controller: cubit.nameController,
                  isPassword: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  title: '',
                  prefixIcon: Icons.person_outline,
                  filled: false),
              MyTextFormField(
                hint: 'Mobile',
                validators: (value) {
                  if (!value.contains('01')) {
                    return 'wrong phone';
                  }
                  if (value.length != 11) {
                    return 'length must be equal 11';
                  }
                  return null;
                },
                maxLength: 11,
                controller: cubit.phoneController,
                isPassword: false,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.number,
                title: '',
                prefixIcon: Icons.phone_android,
                filled: false,
              ),
              MyTextFormField(
                enabled: false,
                hint: 'Email',
                controller: cubit.emailController,
                isPassword: false,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
                title: '',
                prefixIcon: Icons.alternate_email,
                filled: false,
              ),
              MyTextFormField(
                hint: 'SSN',
                enabled: false,
                controller: cubit.ssnController,
                isPassword: false,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.number,
                title: '',
                prefixIcon: Icons.numbers_outlined,
                filled: false,
              ),
              MyTextFormField(
                  hint: 'Specification',
                  controller: cubit.specializationController,
                  isPassword: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  title: '',
                  prefixIcon: Icons.medical_information_outlined,
                  filled: false),
              MyTextFormField(
                  hint: 'Health institute',
                  controller: cubit.healthcareInstituteController,
                  isPassword: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  title: '',
                  prefixIcon: Icons.medical_information_outlined,
                  filled: false),
              Row(
                children: [
                  Expanded(
                    child: MyTextFormField(
                        hint: '',
                        controller: cubit.genderController,
                        isPassword: false,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        title: '',
                        prefixIcon: Icons.man,
                        filled: false),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: MyTextFormField(
                        hint: 'Age',
                        controller: cubit.ageController,
                        isPassword: false,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        title: '',
                        prefixIcon: Icons.numbers,
                        maxLength: 2,
                        filled: false),
                  ),
                ],
              )
            ],
          ),
        );
      },
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

  onStateChange(DAndNProfileState state) {
    if (state is DAndNProfileLoadingState) {
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
    } else if (state is DAndNProfileSuccessState) {
      // push(context, LoginScreen(type: widget.type,));
    } else if (state is DAndNProfileUpdateSuccessState) {
      if(PreferenceUtils.getString(PrefKeys.type) == "0"){
        pushNamedAndRemoveUntil(context, const DoctorHome());
      }
      if(PreferenceUtils.getString(PrefKeys.type) == "1"){
        pushNamedAndRemoveUntil(context, NHomeScreen(type: '',));
      }
    } else if (state is DAndNProfileFailureState) {
      awesomeDialog(state.errorMessage);
    }
  }
  void displayToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red[900],
        textColor: Colors.white,
        fontSize: 16.0);
  }


  @override
  void dispose() {
    super.dispose();
  }
}
