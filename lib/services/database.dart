import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';


class VictimDeviceToken{
  String uid;
  VictimDeviceToken({this.uid});

  CollectionReference victimDeviceReference = Firestore.instance.collection('VictimDeviceToken');

 Future<void> victimDeviceToken(String token) async{
   return await victimDeviceReference.document(uid).setData({
     'victimDeviceToken' : token
   }
   );
  }

}


class SaveVictimLocation{

  CollectionReference saveVictimLocationCollection = Firestore.instance.collection('Location');

  Future<void> saveVictimLocation(GeoFirePoint geoFirePoint) async{
    return await saveVictimLocationCollection.document().setData({
      'userLocation' : geoFirePoint.data

    }
    );
  }

}