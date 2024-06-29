import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/features/nurse/nurse_home/manager/nurse_home_cubit.dart';
import 'package:enurse_system/features/nurse/nurse_home/view/page/nurse_home.dart';
import 'package:enurse_system/features/nurse/patient_personal_info/manager/patein_personal_info_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/widgets/app_drop_down.dart';
import '../../../../../core/widgets/app_text_field.dart';

class UpdatePersonalInfo extends StatefulWidget {
  const UpdatePersonalInfo(
      {super.key,
      required this.docId,
      required this.oldName,
      required this.oldPhone,
      required this.oldCity,
      required this.oldSSN,
      required this.oldAge, required this.oldRoomNumber, required this.oldGender});

  final String docId;
  final String oldName;
  final String oldPhone;
  final String oldCity;
  final String oldRoomNumber;
  final String oldSSN;
  final String oldAge;
  final String oldGender;

  @override
  State<UpdatePersonalInfo> createState() => _UpdatePersonalInfoState();
}

class _UpdatePersonalInfoState extends State<UpdatePersonalInfo> {
  @override
  void initState() {
    super.initState();
    cubit.nameController.text = widget.oldName;
    cubit.phoneController.text = widget.oldPhone;
    cubit.cityController.text = widget.oldCity;
    cubit.nationalIDController.text = widget.oldSSN;
    cubit.ageController.text = widget.oldAge;
    cubit.roomNumberController.text=widget.oldRoomNumber;
  }
  final cubit = PateinPersonalInfoCubit();
  final nurseHomeCubit = NurseHomeCubit();
  final auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider<PateinPersonalInfoCubit>(
          create: (context) {
            return cubit;
          },
        ),
      ],
      child: BlocListener<PateinPersonalInfoCubit, PatientPersonalInfoState>(
        listener: (BuildContext context, PatientPersonalInfoState state) {
          onStateChange(state);
        },
        child: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
              Appbar(),
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
                            enabled: true,
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
                                filled: false,
                                hint: widget.oldGender,
                                count: 4,
                                controller: cubit.genderController2,
                                dropDownList: [
                                  DropDownValueModel(name: "Male", value: "Male"),
                                  DropDownValueModel(
                                      name: "Female", value: "Female"),
                                ],
                                enabled: true,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 2.h,),
                    ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> updateInfo = {
                            "name": cubit.nameController.text,
                            "phone": cubit.phoneController.text,
                            "city": cubit.cityController.text,
                            "ssn": cubit.nationalIDController.text,
                            "age": cubit.ageController.text,
                            "roomNumber": cubit.roomNumberController.text,
                            "gender": cubit.genderController2
                          };
                          await cubit
                              .updatePatientInfo(widget.docId, updateInfo)
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp)),
                          backgroundColor: lightPurpleColor,
                        ),
                        child: Text("Save",style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp
                        )))
                  ],
                ),
              )

            ],
          ),
        )),
      ),
    ));
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
            "Update Patient personal Info ",
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
          enabled: true,
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
