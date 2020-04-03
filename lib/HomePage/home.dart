import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Geolocator geolocator = Geolocator();
  Position _currentPosition;
  String _currentUserAddress = '';

  void _getCurrentUserLocation() {

    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
    .then((Position newPosition){
      setState(() {
        _currentPosition = newPosition;
      });

      _getAddressFromLatLng();

    }).catchError((e){
      print(e.toString());
    });

  }

  void _getAddressFromLatLng() async{
    try{
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark userPlace = p[0];

      setState(() {
        _currentUserAddress =
        '${userPlace.locality}, ${userPlace.postalCode}, ${userPlace.administrativeArea}, ${userPlace.country}';
      });

    }catch(e){
      print(e.toString());
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Criminal Alert'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(_currentUserAddress),
            SizedBox(height: 10,),
            RaisedButton.icon(
              onPressed: () {
                _getCurrentUserLocation();
              },
              icon: Icon(Icons.location_on, color: Colors.white,),
              label: Text('Get Location', style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              elevation: 5.0,
            ),
          ],
        ),
      ),
    );
  }


}

