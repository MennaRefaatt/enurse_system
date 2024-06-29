import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:enurse_system/core/utils/safe_print.dart';
import 'package:enurse_system/shared/my_shared.dart';
import 'package:enurse_system/shared/my_shared_keys.dart';

patientSendNotification() {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  fireStore
      .collection("users")
      .doc(PreferenceUtils.getString(PrefKeys.nurseId))
      .get()
      .then((value) {
    Dio()
        .post("https://fcm.googleapis.com/fcm/send",
            data: {
              "to": value['deviceToken'],
              "notification": {
                "body": "I Need Help",
                "title":
                    "${PreferenceUtils.getString(PrefKeys.name)}\nRoom Number: ${PreferenceUtils.getString(PrefKeys.room)}",
                "sound": "emergency",
                "channel": "nurse",
                "channelKey":"nurse",
                "channelId":"nurse"
              }
            },
            options: Options(headers: {
              "Authorization":
                  "key=AAAAh2jyeys:APA91bESHrA7XGIpUOwjk2jgxYPo04TUCNA_zKr7cLgTmjO_0qflYh-qLofJr9Z3Ynd7XzrDJdkAXZfX_oMiftGEBxhlhHsrDtIF8JcndYR8Ss-b-QKQuNNODtiz9PjaVnqbekxS1ylj"
            }))
        .catchError((e) {
      safePrint(e);
    });
  });
}
