import 'package:enurse_system/core/phone_call.dart';
import 'package:enurse_system/core/patient_send_notification.dart';
import 'package:enurse_system/features/patient/patient_home/manager/patient_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyAndHelp extends StatefulWidget {
  const EmergencyAndHelp({super.key, required this.patientHomeCubit});
final PatientHomeCubit patientHomeCubit;
  @override
  State<EmergencyAndHelp> createState() => _EmergencyAndHelpState();
}

class _EmergencyAndHelpState extends State<EmergencyAndHelp> {

  final Uri _url = Uri.parse('https://flutter.dev');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.emergency_share_outlined, color: Colors.red[900],),
                  Text("Emergency Alert", style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
              SizedBox(height: 1.h,),
              SizedBox(
                height: 5.h,
                width: 50.sp,
                child: ElevatedButton(
                  onPressed:()  => phoneCall(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    backgroundColor: Colors.red[900],
                  ),
                  child: Text('SOS',
                      style: TextStyle(color: Colors.white,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.hail,
                    color: Colors.black,
                    size: 20.sp,),
                  Text("Help Request", style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
              SizedBox(height: 1.h,),
              SizedBox(
                height: 5.h,
                width: 50.sp,
                child: ElevatedButton(
                  onPressed: () {
                        patientSendNotification();
                        Future.delayed( Duration(seconds: 4), () {
                          displayToast("Emergency Alert Send");

                        });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    backgroundColor: Colors.grey[200],
                  ),
                  child: Text('Help',
                      style: TextStyle(color: Colors.red[900],
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ],
          )
        ],
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
        fontSize: 16.0);
  }


  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
