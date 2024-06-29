import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:enurse_system/features/admin/personal_Info/manager/personal_info_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/style/colors/colors.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo(
      {super.key,
        required this.docId,
        required this.name,
        required this.phone,
        required this.specialization,
        required this.healthcareInstitute,
        required this.SSN,
        required this.age,
        required this.email});

  final String docId;
  final String name;
  final String phone;
  final String specialization;
  final String healthcareInstitute;
  final String email;
  final String SSN;
  final String age;

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final cubit = PersonalInfoCubit();
  final List<String> Gender = [
    'Male',
    'Female',
  ];
  String? selectedGenderValue;
  final auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    cubit.nameController.text = widget.name;
    cubit.phoneController.text = widget.phone;
    cubit.healthcareInstituteController.text = widget.healthcareInstitute;
    cubit.specializationController.text = widget.specialization;
    cubit.ssnController.text = widget.SSN;
    cubit.ageController.text = widget.age;
    cubit.emailController.text = widget.email;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => cubit,
        child: BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
          builder: (context, state) {
            if (state is PersonalInfoLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Appbar(),
                        SizedBox(
                          height: 2.h,
                        ),

                        ///Text Form Fields========
                        Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFieldcontroller(cubit.nameController,
                                    Icon(Icons.person), "Name",true),
                                TextFieldcontroller(cubit.emailController,
                                    Icon(Icons.email), "Email",false),
                                TextFieldcontroller(cubit.phoneController,
                                    Icon(Icons.phone), "Phone",true),
                                TextFieldcontroller(cubit.specializationController,
                                    Icon(Icons.location_city), "Specialization",true),
                                TextFieldcontroller(cubit.ssnController,
                                    Icon(Icons.perm_identity_sharp), "SSN",false),
                                TextFieldcontroller(
                                    cubit.healthcareInstituteController,
                                    Icon(Icons.local_hospital_outlined),
                                    "HealthcareInstitute",true),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12.sp),
                                      child: Container(
                                        height: 5.h,
                                        width: 25.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                            BorderRadius.circular(10.sp)),
                                        child: TextField(
                                          controller: cubit.ageController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "        Age"),
                                          onTap: () {},
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.all(10.sp),
                                      child: Container(
                                        height: 5.h,
                                        width: 25.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<String>(
                                            isExpanded: true,
                                            hint: Text(
                                              "Gender",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: Gender.map((String gender) =>
                                                DropdownMenuItem<String>(
                                                  value: gender,
                                                  child: Text(
                                                    gender,
                                                    style:  TextStyle(
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                )).toList(),
                                            value: selectedGenderValue,
                                            onChanged: (String? value) {
                                              selectedGenderValue = value;
                                            },
                                            buttonStyleData:  ButtonStyleData(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.sp),
                                              height: 40,
                                              width: 140,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      Map<String, dynamic> updateInfo = {
                                        "name": cubit.nameController.text,
                                        "email": cubit.emailController.text,
                                        "phone": cubit.phoneController.text,
                                        "healthcareInstitute": cubit
                                            .healthcareInstituteController.text,
                                        "specialization":
                                        cubit.specializationController.text,
                                        "ssn": cubit.ssnController.text,
                                        "age": cubit.ageController.text
                                      };
                                      await cubit
                                          .updatePatientInfo(
                                          widget.docId, updateInfo)
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text("Update"))
                              ],
                            ))
                      ],
                    ),
                  ));
            }
          },
        ));
  }
}

Appbar() {
  return Container(
    height: 20.h,
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
        " personal Info ",
        style: TextStyle(
            fontSize: 21.sp, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),
  );
}

Widget TextFieldcontroller(
    TextEditingController controller, Widget icon, String hintText,bool enabled) {
  return Column(
    children: [
      Padding(
        padding:
        const EdgeInsets.only(top: 20, bottom: 15, left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: controller,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: icon,
                hintText: hintText,
                hintStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: () {},
            enabled: enabled,
          ),
        ),
      ),
    ],
  );
}