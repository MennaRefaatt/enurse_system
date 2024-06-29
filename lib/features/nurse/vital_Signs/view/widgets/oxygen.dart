
import 'package:enurse_system/core/widgets/showNotification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/style/colors/colors.dart';
import '../../model/vitalsigns_model.dart';

class OxygenWidget extends StatefulWidget {
  @override
  State<OxygenWidget> createState() => _OxygenWidgetState();
}

class _OxygenWidgetState extends State<OxygenWidget> {
  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseService(); // Create Firebase service instance
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real-Time Oxygen Chart',
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
  List<OxygenData> oxygenData = []; // List to store oxygen data

  @override
  void initState() {
    super.initState();
    widget.firebaseService.getVitalSignsStream().listen((values) {
      setState(() {
        oxygenData.add(OxygenData(values[2]));
        if (values[3] == 1) {
          showNotification("Emergency", "Oxygen levels are critical!");
        }
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

          // Update oxygen data list only for new values (optimization)
          final oxygen = snapshot.data![2];
          final emergencyFlag = snapshot.data![3];
          if (oxygenData.isEmpty || oxygenData.last.value != oxygen) {
            setState(() {
              oxygenData.add(OxygenData(oxygen));
              if (emergencyFlag == 1) {
                showNotification("Emergency", "Oxygen levels are critical!");
              }
            });
          }


          // Create a ChartSeries object from the oxygen data

          return SfCartesianChart(
              primaryXAxis: CategoryAxis(
                minimum: 0,
                maximum: oxygenData.length.toDouble(),
              ),

              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<OxygenData, int>>[
                LineSeries<OxygenData, int>(
                    color: Color(0XFF8CB9BD),
                    dataSource: oxygenData,
                    xValueMapper: (OxygenData oxygen, index) =>
                    index ,
                    yValueMapper: (OxygenData oxygen, _) => oxygen.value,
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
        final values = vitalSignsString.split(',').map((e) => int.tryParse(e) ?? 0).toList();
        return values;
      } else {
        return [0, 0, 0, 0]; // Default values in case of error
      }
    });
  }
}

