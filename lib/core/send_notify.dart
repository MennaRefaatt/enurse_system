
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:enurse_system/core/utils/safe_print.dart';

sendNotification({required String id, required String body}) {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  fireStore.collection("users").doc(id).get().then((value) {
    safePrint("==========================");
    print("Token ===> ${value['deviceToken']}");
    print("==========================");
    print("==========================");
    print(" id => ${value['deviceToken']}");
    print("==========================");
    Dio()
        .post("https://fcm.googleapis.com/fcm/send",
            data: {
              "to": "cMxfKs5uT1-zDhcJsplNtN:APA91bH08KDQVqlTFbLDBaCFLrsGZa2mI7TV4LT9PvRBANMLUCm95lkh5PM8UsoBoSdQ2LJ0c4x7WX-dfgiv1qXZH6z7QAZUYHIOuoVa3dISo2z540k5UNaO-r_RbQXlKAvmzBULfTqu",
              "notification": {
                "body": body,
                "title": "Register Request",
                "sound": "accept",
                "channel": "nurse",
                "channelKey":"nurse",
                "channelId":"nurse"


        }
            },
            options: Options(headers: {
              "Authorization":
                  "key=AAAAh2jyeys:APA91bESHrA7XGIpUOwjk2jgxYPo04TUCNA_zKr7cLgTmjO_0qflYh-qLofJr9Z3Ynd7XzrDJdkAXZfX_oMiftGEBxhlhHsrDtIF8JcndYR8Ss-b-QKQuNNODtiz9PjaVnqbekxS1ylj"
            })).then((value) => safePrint("sent"))
        .catchError((e) {
      safePrint(e);
    });

  });
}
