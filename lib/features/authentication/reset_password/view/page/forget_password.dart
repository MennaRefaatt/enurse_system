import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../manger/forget_cubit.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final cubit =ForgetCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (context) => cubit,
    child: BlocListener<ForgetCubit, ForgetState>(
    listener: (context, state) => onStateChange(state),
    child: Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h,),
            Center(child: forgetWidget()),
          ],
        ),
      ),
    ),)
);
  }

  Widget forgetWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please enter your email address to recover your password.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Empty email';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email, color: Colors.black54,),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 5.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      String email =emailController.text;
                      cubit.resetPassword(email,);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightPurpleColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                  ),
                  child: const Text ('Reset Password',
                    style: TextStyle(color: Colors.white),),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 50.w,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () => pop(context,),
                  child: const Text ('Go back',style: TextStyle(color: Colors.black),),
                ),
              ),
            ]
        ),
      ),
    );
  }
  void displayToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  void onForgetSuccess(){
  showDialog(context: context,
      barrierDismissible: false,
      builder: (context) =>
      const Center(child: CircularProgressIndicator(),));
  Navigator.of(context).pop();
}
  onStateChange( ForgetState state) {
    if(state is ForgetLoadingState){
      showDialog(context: context, builder: (context) {
        return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
              backgroundColor: Colors.grey,
            ));
      },);
    }
    else if(state is ForgetSuccessState){
      onForgetSuccess();
    }
    else if(state is ForgetFailureState){
      awesomeDialog(state.errorMessage);
    }
  }
  void awesomeDialog(String message){
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
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
