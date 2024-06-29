import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RequestItem extends StatefulWidget {
  const RequestItem(
      {super.key, required this.name, required this.image, required this.onAccept, required this.onReject,});

  final String name, image;
  final VoidCallback onAccept, onReject;

  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.sp),
      child: Column(
        children: [
          Row(
            children: [
              // CircleAvatar(
              //   radius: 23.sp,
              //   backgroundImage: NetworkImage(
              //       widget.cubit.requestedDataModel[index].image),
              // ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                widget.name,
                style: TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 16.sp),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(
                onPressed: () {
                  awesomeDialog(message:"Are You Sure to accept?",accept: true);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  backgroundColor: greyColor,
                ),
                child: Text('Accept',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              SizedBox(
                width: 3.w,
              ),
              ElevatedButton(
                onPressed: (){
                  awesomeDialog(message:"Are You Sure to reject?", accept: false);

                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  backgroundColor: Colors.red[900],
                ),
                child: Text('Decline',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  void awesomeDialog({required String message, required bool accept}) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      // title: message,
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: accept ? widget.onAccept : widget.onReject,
    ).show();
  }
}
