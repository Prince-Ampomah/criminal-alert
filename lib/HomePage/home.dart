import 'dart:async';
import 'package:criminal_alert/HomePage/showSnackBar.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Location/storeUserLocation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  StreamSubscription<DataConnectionStatus> listener;


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
                onPressed: () async => await UserLocation().storeUserLocation(),
                icon: Icon(Icons.location_on, color: Colors.white),
                label: Text('Alert Police Now!!', style: TextStyle(color: Colors.white),),
                color: Colors.red.shade700,
                splashColor: Colors.white,
                elevation: 5.0,
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

