import 'package:enurse_system/features/nurse/vital_Signs/model/vitalsigns_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/style/colors/colors.dart';
import '../../../../../core/widgets/showNotification.dart';

class TempWidget extends StatefulWidget {
  @override
  State<TempWidget> createState() => _TempWidgetState();
}

class _TempWidgetState extends State<TempWidget> {
  @override
  Widget build(BuildContext context) {
    final firebaseService =
        FirebaseService(); // Create Firebase service instance
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real-Time Temperature Chart',
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
  List<TempData> tempData = []; // List to store temperature data

  @override
  void initState() {
    super.initState();
    widget.firebaseService.getVitalSignsStream().listen((values) {
      setState(() {
        tempData.add(TempData(values[0]));
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

          // Update temperature data list only for new values (optimization)
          final temp = snapshot.data![0];
          final emergencyFlag = snapshot.data![3];

          if (tempData.isEmpty || tempData.last.value != temp) {
            setState(() {
              tempData.add(TempData(temp));
              if (emergencyFlag == 1) {
                showNotification(
                    "Emergency", "Temperature levels are critical!");
              }
            });
          }

          // Create a ChartSeries object from the temperature data

          return SfCartesianChart(
              primaryXAxis: CategoryAxis(
                minimum: 0,
                maximum: tempData.length.toDouble(),
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<TempData, int>>[
                LineSeries<TempData, int>(
                    color: Color(0XFFFE5775),
                    dataSource: tempData,
                    xValueMapper: (TempData temp, index) => index ,
                    yValueMapper: (TempData temp, _) => temp.value,
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
