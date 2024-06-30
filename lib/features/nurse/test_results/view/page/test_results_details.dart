
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../../../../core/utils/snack_bar_app.dart';
import '../../../../../core/widgets/app_image.dart';
import '../../../../../shared/my_shared.dart';
import '../../../../../shared/my_shared_keys.dart';
import '../../../rays/view/page/photo_view.dart';
import '../../manager/test_results_cubit.dart';

class TestResultsDetails extends StatefulWidget {
  const TestResultsDetails({
    super.key,
    required this.cubit,
    required this.index, required this.name,
    required this.patientId, required this.type
  });
  final String name;
  final TestResultsCubit cubit;
  final int index;
  final String patientId ;
  final String type ;

  @override
  State<TestResultsDetails> createState() => _TestResultsDetailsState();
}

class _TestResultsDetailsState extends State<TestResultsDetails> {
  @override
  void initState() {
    widget.cubit.getTestResults(
      patientId:widget.patientId
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(18.sp),
            decoration: BoxDecoration(
                color: lightPurpleColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15.sp),
                    bottomLeft: Radius.circular(15.sp))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      widget.cubit.testResultModel[widget.index].title,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),

                  ],
                ),
                Visibility(
                  visible:PreferenceUtils.getString(PrefKeys.type) == "1",
                  child: IconButton(
                    onPressed: () {
                      awesomeDialog(message: "Are you sure to delete this test result?", index: widget.index, );
                    },
                    icon: Icon(Icons.delete,color: Colors.red[900],size: 25.sp,),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.sp),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.all(10.sp),
                        child: InkWell(
                          onTap: () => push(context, PhotoViewPage(imageUrl: widget.cubit.testResultModel[widget.index].images[index])),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.sp),
                            child: AppImage(
                                imageUrl: widget.cubit
                                    .testResultModel[widget.index].images[index],
                                width: 20.w,
                                height: 10.h),
                          ),
                        ));
                  },
                  itemCount:
                      widget.cubit.testResultModel[widget.index].images.length,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  void awesomeDialog({required String message,required int index}) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        animType: AnimType.rightSlide,
        btnCancelColor: Colors.red[900],

        // title: message,
        desc: message,
        btnCancelOnPress: () {},
        btnOkOnPress:() {
          widget.cubit.deleteTestResults(widget.cubit.testResultModel[index]);
          pop(context);
          snackBar(context, "deleted successfully", lightPurpleColor);
        }
    ).show();
  }
}
