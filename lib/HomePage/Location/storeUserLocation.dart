import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criminal_alert/HomePage/internetConnectivity.dart';
import 'package:criminal_alert/HomePage/showSnackBar.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';

class UserLocation {
  final Geolocator geoLocator = Geolocator();
  Position _currentPosition;

  //Get User Location
  Future _getCurrentUserLocation() async {
    try {
      await geoLocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((Position newPosition) {
        _currentPosition = newPosition;
        print(_currentPosition);
      });
    } catch (e) {
      print(e.toString());
    }
  }


  //Database Instances
  Geoflutterfire _geoFlutterFire = Geoflutterfire();
  CollectionReference locationCollection =
      Firestore.instance.collection('Location');

// ignore: missing_return //Add User location in Firestore
  Future storeUserLocation() async {
    try {
      DataConnectionStatus connectionStatus = await checkInternetConnection();
      if (connectionStatus == DataConnectionStatus.connected) {
        alertSnackBar();
        await _getCurrentUserLocation();
        GeoFirePoint geoPoint = _geoFlutterFire.point(
            latitude: _currentPosition.latitude,
            longitude: _currentPosition.longitude);
        return await locationCollection.add({
          'userLocation': geoPoint.data,
        });
      } else {
        Future.delayed(
            Duration(seconds: 2),
                ()=>connectionSnackbar()
        );

      }
    } catch (e) {
      print(e.toString());
    }
  }
}
