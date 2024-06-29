import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enurse_system/shared/my_shared.dart';
import 'package:enurse_system/shared/my_shared_keys.dart';
import 'package:url_launcher/url_launcher.dart';

 phoneCall ()  {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.collection("users").doc(
    PreferenceUtils.getString(PrefKeys.nurseId)
  ).get().then((value) async {
    final Uri url= Uri(
        scheme: "tel",
        path: value["phone"],
    );
    if(await canLaunchUrl(url)){
    await launchUrl(url);
    }else{
    print("cannot launch ");
    }
  });

}