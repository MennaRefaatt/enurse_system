import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/nurse/allergies/manager/allergies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../../../../core/utils/snack_bar_app.dart';
import '../../../../../core/widgets/app_text_field.dart';

class AddAllergiesScreen extends StatefulWidget {
  const AddAllergiesScreen({super.key, required this.cubit, required this.name, required this.id, required this.type});

  final AllergiesCubit cubit;
  final String name;
  final String id;
  final String type;

  @override
  State<AddAllergiesScreen> createState() => _AddAllergiesScreenState();
}

class _AddAllergiesScreenState extends State<AddAllergiesScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.cubit,
      child: BlocListener<AllergiesCubit, AllergiesState>(
        listener: (context, state) {
          if (state is AddAllergiesSuccessState) {
pop(context);            safePrint("object");
          }
          if (state is AddAllergiesFailureState) {
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
                        "Add Allergies",
                        style: TextStyle(
                            color: lightPurpleColor,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Visibility(
                      visible:  widget.type=='Foods to avoid',
                      child: MyTextFormField(
                        filled: true,
                        validators: (value) {
                          if (value!.isEmpty) {
                            return 'please enter Foods to avoid';
                          }
                          return null;
                        },
                        controller: widget.cubit.avoidFoodsController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        title: 'Foods To Avoid',
                        hint: '',
                        isPassword: false,
                        prefixIcon: Icons.edit,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Visibility(
                      visible:  widget.type=='chemical sides',
                      child: MyTextFormField(
                        filled: true,
                        validators: (value) {
                          if (value!.isEmpty) {
                            return 'please enter Chemical Sides';
                          }
                          return null;
                        },
                        controller: widget.cubit.chemicalSidesController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        title: 'Chemical Sides',
                        hint: '',
                        isPassword: false,
                        prefixIcon: Icons.edit,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          if ( !formKey
                              .currentState!.validate()) {
                            snackBar(
                                context, "Please fill all Allergies data",
                                Colors.red);
                          } else {
                            saveAllergiesData();
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp)),
                          backgroundColor: Colors.white,
                        ),
                        child:  Text(
                          'Done',
                          style: TextStyle(
                              color: lightPurpleColor, fontSize: 20.sp),
                        ),
                      ),
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
  void saveAllergiesData() {
    widget.cubit.saveAllergiesData(patientId: widget.id, patientName: widget.name);
  }
@override
  void dispose() {
    widget.cubit.avoidFoodsController.dispose();
    widget.cubit.chemicalSidesController.dispose();
    widget.cubit.allergiesModel.clear();
    super.dispose();
  }
}