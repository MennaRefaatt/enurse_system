import 'package:enurse_system/features/nurse/rays/view/widgets/rays_app_bar.dart';
import 'package:enurse_system/features/nurse/rays/view/widgets/rays_widget.dart';
import 'package:enurse_system/shared/my_shared.dart';
import 'package:enurse_system/shared/my_shared_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/utils/navigators/navigators.dart';
import '../../manager/rays_cubit.dart';
import '../widgets/add_ray.dart';

class Rays extends StatefulWidget {
  Rays({super.key, required this.patientId, required this.name, required this.type});

  final String patientId;
  final String name;
  final String type ;


  @override
  State<Rays> createState() => _RaysState();
}

class _RaysState extends State<Rays> {
  final cubit = RaysCubit();
  @override
  void initState() {
    cubit.getRays(patientId: widget.patientId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getRays(patientId: widget.patientId),
      child: BlocListener<RaysCubit, RaysState>(
        listener: (context, state) {},
        child: Scaffold(
          floatingActionButton: Visibility(
            visible: PreferenceUtils.getString(PrefKeys.type) == "1",
            child: FloatingActionButton(
                child: Icon(Icons.add,color: Colors.white,),
                backgroundColor: lightPurpleColor,
                onPressed: () {
                  push(
                      context,
                      AddRay(
                        patientId: widget.patientId,
                      ));
                }),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              RaysAppBar(
                name: widget.name,
              ),
              RaysWidget(
                cubit: cubit,
                name: widget.name, patientId: widget.patientId, type:widget.type,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
