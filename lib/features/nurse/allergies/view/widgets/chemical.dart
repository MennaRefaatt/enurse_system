import 'package:enurse_system/core/style/colors/colors.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/features/nurse/allergies/manager/allergies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChemicalWidget extends StatefulWidget {
  const ChemicalWidget({super.key, required this.cubit});
  final AllergiesCubit cubit;

  @override
  State<ChemicalWidget> createState() => _ChemicalWidgetState();
}

class _ChemicalWidgetState extends State<ChemicalWidget> {
  final cubit = AllergiesCubit();
  @override
  void initState() {

    safePrint("==>${widget.cubit.allergiesModel.fold(0, (previousValue, element) =>previousValue + element.chemicalSides.length)}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllergiesCubit,AllergiesState>(builder: (context,state){
      if(state is GetAllergiesFailureState){
        return CircularProgressIndicator(
          color: lightPurpleColor,
        );

      }else{
        return widget.cubit.allergiesModel.fold(0, (previousValue, element) =>previousValue + element.chemicalSides.length) != 0 ?
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:  widget.cubit.allergiesModel.fold(0, (previousValue, element) =>previousValue + element.chemicalSides.length) == 0 ?0:widget.cubit.allergiesModel.length,
            itemBuilder: (context, index){
              return Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(10.sp),
                    child: Row(
                      children: [
                        Visibility(
                          visible: widget.cubit.allergiesModel[index].chemicalSides.isNotEmpty ,
                          child: Text(
                            widget.cubit.allergiesModel[index].chemicalSides,
                            style: TextStyle( fontSize: 19.sp,fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.cubit.allergiesModel[index].chemicalSides.isNotEmpty ,
                    child: Divider(
                      indent: 15.sp,
                      endIndent: 15.sp,
                    ),
                  ),
                ],
              );
            })
            : Text("no chemical to avoid",style: TextStyle(fontSize: 20.sp),);
      }
    });
  }
}

