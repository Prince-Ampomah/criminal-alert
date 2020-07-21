import 'package:criminal_alert/shared_widget/app_bar_widget.dart';
import 'package:criminal_alert/shared_widget/bottom_bar_screen_list.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int showScreens = 0;
  void onBottomTap(int index) => setState(() => showScreens = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: onBottomTap,
        color: Colors.redAccent,
        buttonBackgroundColor: Colors.red,
        backgroundColor: Colors.white70,
        height: 55.0,
        animationDuration: Duration(milliseconds:500),
        items: <Widget>[
          Icon(Icons.location_on, size: 27, color: Colors.white),
          Icon(Icons.chat, size: 27, color: Colors.white),
          Icon(Icons.notifications, size: 27, color: Colors.white),
        ],
      ),
      body: listScreens[showScreens],
    );
  }
}
