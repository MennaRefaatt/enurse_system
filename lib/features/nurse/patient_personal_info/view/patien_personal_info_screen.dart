import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/features/nurse/create_patient_account/manager/create_patient_account_cubit.dart';
import 'package:enurse_system/features/nurse/nurse_home/view/page/nurse_home.dart';
import 'package:enurse_system/features/nurse/patient_personal_info/manager/patein_personal_info_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/style/colors/colors.dart';
import '../../../../core/widgets/app_text_field.dart';

class PatientPersonalInfoScreen extends StatefulWidget {
  const PatientPersonalInfoScreen(
      {super.key,
      required this.docId,
      required this.name,
      required this.phone,
      required this.city,
      required this.SSN,
      required this.age,
      required this.roomNumber, required this.gender});

  final String docId;
  final String name;
  final String phone;
  final String city;
  final String roomNumber;
  final String SSN;
  final String age;
  final String gender;


  @override
  State<PatientPersonalInfoScreen> createState() =>
      _PatientPersonalInfoScreenState();
}

class _PatientPersonalInfoScreenState extends State<PatientPersonalInfoScreen> {
  @override
  void initState() {
    super.initState();
    cubit.nameController.text = widget.name;
    cubit.phoneController.text = widget.phone;
    cubit.cityController.text = widget.city;
    cubit.nationalIDController.text = widget.SSN;
    cubit.ageController.text = widget.age;
    cubit.genderController1.text = widget.gender;
    cubit.roomNumberController.text = widget.roomNumber;
  }

  final cubit = PateinPersonalInfoCubit();
  final createPatientAccountCubit = CreatePatientAccountCubit();
  final auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<PateinPersonalInfoCubit, PatientPersonalInfoState>(
        listener: (BuildContext context, PatientPersonalInfoState state) {
          onStateChange(state);
        },
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              Appbar(),
              ///Text Form Fields========
              Padding(
                padding: EdgeInsets.all(15.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFieldcontroller(
                        cubit.nameController, Icons.perm_contact_cal_rounded, "Name","Name"),
                    TextFieldcontroller(cubit.phoneController,
                        Icons.phone, "Phone","Phone"),
                    TextFieldcontroller(cubit.cityController,
                        Icons.location_city, "City","City"),
                    TextFieldcontroller(cubit.nationalIDController,
                        Icons.perm_identity_sharp, "SSN","SSN"),
                    TextFieldcontroller(cubit.roomNumberController,
                        Icons.room, "Room Number","Room Number"),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: MyTextFormField(
                            filled: false,
                            maxLength: 2,
                            controller: cubit.ageController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            title: 'Age',
                            hint: '',
                            isPassword: false,
                            prefixIcon: Icons.edit,
                            enabled: false,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: MyTextFormField(
                            filled: false,
                            maxLength: 2,
                            controller: cubit.genderController1,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            title: 'Gender',
                            hint: '',
                            enabled: false,
                            isPassword: false,
                            prefixIcon: Icons.edit,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Appbar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
          color: lightPurpleColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.sp),
              bottomLeft: Radius.circular(15.sp))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4.h,
          ),
          Text(
            "Patient personal Info ",
            style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget TextFieldcontroller(TextEditingController controller,IconData icon,
      String hintText, String title) {
    return Column(
      children: [
        MyTextFormField(
          filled: false,
          controller: controller,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          title: title,
          hint: hintText,
          isPassword: false,
          enabled: false,
          prefixIcon: icon,
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }

  onStateChange(PatientPersonalInfoState state) {
    if (state is PatientPersonalInfoLoadingState) {
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
    } else if (state is PatientPersonalInfoSuccess) {
      push(
          context,
          NHomeScreen(
            type: "2",
          ));
    } else if (state is PatientPersonalInfoFailure) {
      awesomeDialog(state.errorMessage);
    }
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
}
