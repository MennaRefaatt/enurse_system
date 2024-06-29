import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/widgets/showNotification.dart';
import '../../model/vitalsigns_model.dart';

class PulseWidget extends StatefulWidget {
  @override
  State<PulseWidget> createState() => _PulseWidgetState();
}

class _PulseWidgetState extends State<PulseWidget> {
  @override
  Widget build(BuildContext context) {
    final firebaseService =
        FirebaseService(); // Create Firebase service instance
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real-Time Pulse Chart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(firebaseService: firebaseService),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FirebaseService firebaseService;

  const MyHomePage({Key? key, required this.firebaseService}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PulseData> pulseData = []; // List to store pulse data

  @override
  void initState() {
    super.initState();
    widget.firebaseService.getVitalSignsStream().listen((values) {
      setState(() {
        pulseData.add(PulseData(values[1]));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<int>>(
        stream: widget.firebaseService.getVitalSignsStream(),
        builder: (context, AsyncSnapshot<List<int>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const CircularProgressIndicator(
              color: lightPurpleColor,
            );
          }

          // Update pulse data list only for new values (optimization)
          final pulse = snapshot.data![1];
          final emergencyFlag = snapshot.data![3];
          if (pulseData.isEmpty || pulseData.last.value != pulse) {
            setState(() {
              pulseData.add(PulseData(pulse));
              if (emergencyFlag == 1) {
                showNotification("Emergency", "Pulse levels are critical!");
              }
            });
          }

          // Create a ChartSeries object from the pulse data

          return SfCartesianChart(
              primaryXAxis: CategoryAxis(
                minimum: 0,
                maximum: pulseData.length.toDouble(),
              ),

              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<PulseData, int>>[
                LineSeries<PulseData, int>(
                    color: Color(0XFFF3A53F),
                    dataSource: pulseData,
                    xValueMapper: (PulseData pulse, index) => index ,
                    yValueMapper: (PulseData pulse, _) => pulse.value,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]);
        },
      ),
    );
  }
}

class FirebaseService {
  final databaseReference = FirebaseDatabase.instance.ref();

  Stream<List<int>> getVitalSignsStream() {
    final vitalSignsRef = databaseReference.child('vitalSigns');
    return vitalSignsRef.onValue.map((event) {
      final snapshot = event.snapshot;
      if (snapshot.value is String) {
        final vitalSignsString = snapshot.value as String;
        final values = vitalSignsString
            .split(',')
            .map((e) => int.tryParse(e) ?? 0)
            .toList();
        return values;
      } else {
        return [0, 0, 0, 0]; // Default values in case of error
      }
    });
  }
}
