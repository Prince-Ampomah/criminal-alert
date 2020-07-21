import 'package:criminal_alert/location/storeUserLocation.dart';
import 'package:criminal_alert/snackbar/showSnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AlertPoliceScreen extends StatefulWidget {
  @override
  _AlertPoliceScreenState createState() => _AlertPoliceScreenState();
}

class _AlertPoliceScreenState extends State<AlertPoliceScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/location_illustrator.png', scale: 5),
                  SizedBox(height: 10.0,),
                  RaisedButton.icon(
                    onPressed: () async => await UserLocation().storeUserLocation(),
                    icon: Icon(Icons.location_on, color: Colors.white),
                    label: Text(
                      'Alert Police Now!!',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    splashColor: Colors.white,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
