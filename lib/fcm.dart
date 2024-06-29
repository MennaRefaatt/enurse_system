import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initFCM() {
  try {
    initLocalNotifications();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      safePrint("FirebaseMessaging.onMessage");

      if (message.notification != null) {
        safePrint("FirebaseMessaging.onMessage 2");

        String body = message.notification!.body!;
        String title = message.notification!.title!;
        String sound = message.notification!.android!.sound!;

        safePrint("---------------------");
        safePrint("$sound");
        safePrint("---------------------");
        _showAlertNotification(title, body, sound);
      }
    });

    FirebaseMessaging.onBackgroundMessage(fcmBackgroundMessages);

    FirebaseMessaging.instance.getToken().then(
          (value) => safePrint("FCM Token => $value"),
        );
  } catch (error) {
    safePrint(error);
  }
}

Future<void> fcmBackgroundMessages(RemoteMessage message) async {
  safePrint("fcmBackgroundMessages");

  if (message.notification == null) {
    return;
  }

  String title = message.notification!.title!;
  String body = message.notification!.body!;
  String sound = message.notification!.android!.sound!;
  safePrint("====================================================>" + sound);
  _showAlertNotification(title, body, sound);
}

void initLocalNotifications() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("mipmap/launcher_icon");

  // const IOSInitializationSettings initializationSettingsIOS =
  // IOSInitializationSettings();

  DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    onDidReceiveLocalNotification: (id, title, body, payload) {
      // String titleTr = title!.localTr();
      // String bodyTr = body!.localTr();
      //
      // _showNotification(titleTr, bodyTr);
    },
  );

  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> _showAlertNotification(
    String title, String body, String sound) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'nurse',
    'nurse',
    channelDescription: 'enurse_system notification channel',
    playSound: true,
    sound: RawResourceAndroidNotificationSound(sound),
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    body.hashCode,
    title,
    body,
    platformChannelSpecifics,
  );
}
