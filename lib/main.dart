import 'package:enurse_system/app.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/shared/my_shared.dart';
import 'package:enurse_system/shared/my_shared_keys.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'fcm.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PreferenceUtils.init();
  safePrint(PreferenceUtils.getString(PrefKeys.nurseId));
  safePrint("my Id ${PreferenceUtils.getString(PrefKeys.userId)}");
  safePrint("type ${PreferenceUtils.getString(PrefKeys.type)}");
  safePrint("name==============> ${PreferenceUtils.getString(PrefKeys.name)}");

  //notifications permission
  // Request notification permission if it is denied
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  if (PreferenceUtils.getString(PrefKeys.userId).isNotEmpty) {
    FirebaseMessaging.instance.getToken().then((value) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .collection("users")
          .doc(PreferenceUtils.getString(PrefKeys.userId))
          .update({"deviceToken": value});
    });
  }
  initFCM();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  runApp(const MyApp());
}

