import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/doctor/patient_log/view/widgets/weeks_data.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../manager/patient_log_cubit.dart';

class TabBarWidget extends StatefulWidget  {
  const TabBarWidget({super.key, required this.cubit});
  final  PatientLogCubit cubit;
  @override
  State<TabBarWidget> createState() => _TabBarWidget();
}

class _TabBarWidget extends State<TabBarWidget> with SingleTickerProviderStateMixin {
  late TabController _controller;
  String selectedLabel =""; // You can access the label here

  final List<Tab> myTabs = <Tab>[
    Tab(child:Text('Week One'),),
    Tab(child:Text('Week Two'),),
    Tab(child:Text('Week Three'),),
    Tab(child:Text('Week Four'),),
  ];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: myTabs.length,vsync: this);
    _controller.addListener(_handleTabSelection);
    _controller.animateTo((_controller.index + 1) % 2);

  }
  void _handleTabSelection() {
    if (_controller.indexIsChanging) {
      // This method will be called whenever a new tab is selected
      String selectedLabel = _controller.index.toString(); // You can access the label here
      safePrint('Selected label: $selectedLabel');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: TabBar(
              labelStyle:  TextStyle(fontSize: 18.sp),
              labelColor: lightPurpleColor,
              indicatorWeight: 0.5.w,
               key: GlobalKey(),
              //unselectedLabelColor: Colors.black,
              //indicatorColor: Colors.black,
              controller: _controller,
              isScrollable: true,
              dividerColor: Colors.white,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp), // Creates border
                  color: Colors.white),
              tabs:  myTabs),
        ),


        SizedBox(
          height: 77.h,
          child: TabBarView(
              controller: _controller,
              children:myTabs.map((Tab tab) {
            return WeeksData(cubit: widget.cubit,);
            }
          ).toList(),
        ),
          ),
    ]
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
