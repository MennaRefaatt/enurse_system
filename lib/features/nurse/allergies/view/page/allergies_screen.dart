import 'package:enurse_system/core/utils/navigators/navigators.dart';
import 'package:enurse_system/features/nurse/allergies/manager/allergies_cubit.dart';
import 'package:enurse_system/features/nurse/allergies/view/widgets/add_allergies_screen.dart';
import 'package:enurse_system/features/nurse/allergies/view/widgets/allergies_app%20bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../../../../shared/my_shared.dart';
import '../../../../../shared/my_shared_keys.dart';
import '../widgets/avoid_foods.dart';
import '../widgets/chemical.dart';

class AllergiesScreen extends StatefulWidget {
  const AllergiesScreen(
      {super.key, required this.name, required this.id, required this.type});
  final String name;
  final String id;
  final String type;

  @override
  State<AllergiesScreen> createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  final cubit = AllergiesCubit();

  @override
  void initState() {
    cubit.getAllergies(patientId: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<AllergiesCubit, AllergiesState>(
        listener: (BuildContext context, AllergiesState state) {},
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                AllergiesAppBar(
                  patientName: widget.name,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: Row(
                        children: [
                          Text(
                            "FOODS TO ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.sp),
                          ),
                          Text(
                            "AVOID ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Colors.red),
                          )
                        ],
                      ),
                    ),
                    AvoidFoodsWidget(
                      cubit: cubit,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: Row(
                        children: [
                          Text(
                            "CHEMICAL ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.sp),
                          ),
                          Text(
                            "SIDES ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Colors.red),
                          )
                        ],
                      ),
                    ),
                    ChemicalWidget(cubit: cubit),
                  ],
                ),
                Visibility(
                  visible: PreferenceUtils.getString(PrefKeys.type) == "1",
                  child: Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    color: lightPurpleColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(21.sp),
                                        topRight: Radius.circular(21.sp)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextButton(
                                        child:
                                         Text('Add Foods to avoid',style: TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold,fontSize: 18.sp),),
                                        onPressed: () {
                                          push(context, AddAllergiesScreen(
                                                        cubit: cubit,
                                                        name: widget.name,
                                                        id: widget.id, type: 'Foods to avoid',));
                                        }
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                      ),
                                      TextButton(
                                        child:
                                         Text('Add chemical sides',
                                          style: TextStyle(color: Colors.white,
                                              fontWeight: FontWeight.bold,fontSize: 18.sp),),
                                          onPressed: () {
                                            push(context, AddAllergiesScreen(
                                              cubit: cubit,
                                              name: widget.name,
                                              id: widget.id, type: 'chemical sides',));
                                          }
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp)),
                          backgroundColor: lightPurpleColor,
                        ),
                        child: Text(
                          'Add ',
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.sp),
                        ),
                      ),
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
  @override
  void dispose() {
    cubit.avoidFoodsController.dispose();
    cubit.chemicalSidesController.dispose();
    cubit.allergiesModel.clear();
    super.dispose();
  }
}
