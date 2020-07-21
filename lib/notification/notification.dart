
import 'package:criminal_alert/services/database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PhoneToken{
  String uid;
  PhoneToken({this.uid});

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future phoneToken(){
    firebaseMessaging.getToken().then((token) async{
      print('victim token: $token');
      return VictimDeviceToken(uid: uid).victimDeviceToken(token);
    });
  }

}