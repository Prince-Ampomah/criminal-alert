import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criminal_alert/HomePage/internetConnectivity.dart';
import 'package:criminal_alert/HomePage/showSnackBar.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Geolocator geoLocator = Geolocator();
  Position _currentPosition;

  StreamSubscription<DataConnectionStatus> listener;


  //Get User Current Location
  Future _getCurrentUserLocation() async{
    try{
      await geoLocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((Position newPosition){
        _currentPosition = newPosition;
        setState(() {
          _currentPosition = newPosition;
          print(_currentPosition);
        });
      });

    }catch (e){
      print(e.toString());
    }

  }

  //Database Instances
  Geoflutterfire _geoFlutterFire = Geoflutterfire();
  CollectionReference locationCollection = Firestore.instance.collection('Location');


  // ignore: missing_return //Add User location in Firestore
  Future<DocumentReference> addUserLocation() async{

    try{

      DataConnectionStatus status = await checkInternetConnection();//checks internet connection
      if(status == DataConnectionStatus.connected){
        alertSnackBar();
        await _getCurrentUserLocation();
        GeoFirePoint geoPoint = _geoFlutterFire.point(latitude: _currentPosition.latitude, longitude: _currentPosition.longitude);
        return locationCollection.add({
          'userLocation': geoPoint.data,
        });
      }
      else{
          connectionSnackbar();
      }

    }catch(e){
      print(e.toString());
    }
  }


  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Criminal Alert Client'),
      ),
      body: Builder(builder: (context){
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                onPressed: () async{
                  await addUserLocation();
                },
                icon: Icon(Icons.location_on, color: Colors.white),
                label: Text('Alert Police Now!!', style: TextStyle(color: Colors.white),),
                color: Colors.red.shade700,
                splashColor: Colors.white,
                elevation: 5.0,
                animationDuration: Duration(seconds: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
            ],
          ),
        );
      },),
    );
  }


}

