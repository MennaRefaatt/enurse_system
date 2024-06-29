import 'package:enurse_system/features/nurse/vital_Signs/view/widgets/Temperature.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enurse_system/features/nurse/vital_Signs/view/widgets/oxygen.dart';
import 'package:enurse_system/features/nurse/vital_Signs/view/widgets/pulse.dart';
import 'package:enurse_system/features/nurse/vital_Signs/view/widgets/app_bar_widget.dart';
import 'package:enurse_system/core/style/colors/colors.dart';

class VitalSignsPage extends StatefulWidget {
  const VitalSignsPage({Key? key, required this.name, required this.id})
      : super(key: key);

  final String name;
  final String id;

  @override
  State<VitalSignsPage> createState() => _VitalSignsPageState();
}

class _VitalSignsPageState extends State<VitalSignsPage> {
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            VitalSignsAppBar(patientName: widget.name),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      /// Temperature Section ==========================================
                      _buildVitalSignStream(
                        stream: firebaseService.getTemperatureStream(),
                        title: 'Temperature',
                        iconAsset: 'assets/icons/tempColor.png',
                        chartWidget: TempWidget(),
                      ),

                      /// Pulse Section ==========================================
                      _buildVitalSignStream(
                        stream: firebaseService.getPulseStream(),
                        title: 'Pulse',
                        iconAsset: 'assets/icons/yellow.png',
                        chartWidget: PulseWidget(),
                      ),

                      /// Oxygen Section ==========================================
                      _buildVitalSignStream(
                        stream: firebaseService.getOxygenStream(),
                        title: 'Oxygen',
                        iconAsset: 'assets/icons/oxygenColor.png',
                        chartWidget: OxygenWidget(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalSignStream({
    required Stream<int> stream,
    required String title,
    required String iconAsset,
    required Widget chartWidget,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '  $title',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 70,
            child: StreamBuilder<int>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: lightPurpleColor,
                    ),
                  );
                }

                var value = snapshot.data!;

                return Row(
                  children: [
                    Image.asset(
                      iconAsset,
                      height: 37,
                      width: 37,
                    ),
                    SizedBox(width: 20),
                    Text(
                      value.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: chartWidget,
          ),
        ),
      ],
    );
  }
}

class FirebaseService {
  final databaseReference = FirebaseDatabase.instance.ref();

  Stream<int> getTemperatureStream() {
    final vitalSignsRef = databaseReference.child('vitalSigns');
    return vitalSignsRef.onValue.map((event) {
      final snapshot = event.snapshot;
      if (snapshot.value is String) {
        final values = snapshot.value as String;
        final splitValues =
            values.split(',').map((e) => int.tryParse(e) ?? 0).toList();
        return splitValues[0]; // Temperature value
      } else {
        return 0; // Default value in case of error
      }
    });
  }

  Stream<int> getPulseStream() {
    final vitalSignsRef = databaseReference.child('vitalSigns');
    return vitalSignsRef.onValue.map((event) {
      final snapshot = event.snapshot;
      if (snapshot.value is String) {
        final values = snapshot.value as String;
        final splitValues =
            values.split(',').map((e) => int.tryParse(e) ?? 0).toList();
        return splitValues[1]; // Pulse value
      } else {
        return 0; // Default value in case of error
      }
    });
  }

  Stream<int> getOxygenStream() {
    final vitalSignsRef = databaseReference.child('vitalSigns');
    return vitalSignsRef.onValue.map((event) {
      final snapshot = event.snapshot;
      if (snapshot.value is String) {
        final values = snapshot.value as String;
        final splitValues =
            values.split(',').map((e) => int.tryParse(e) ?? 0).toList();
        return splitValues[2]; // Oxygen value
      } else {
        return 0; // Default value in case of error
      }
    });
  }
}
