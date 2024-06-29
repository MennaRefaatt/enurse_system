import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../../fcm.dart';

void showNotification(String title, String body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'emergency_channel', // channel id
    'Emergency Notifications', // channel name
    // 'Channel for emergency notifications', // channel description
    sound: RawResourceAndroidNotificationSound('alert'),

    importance: Importance.high,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
    payload: 'item x',
  );
}
