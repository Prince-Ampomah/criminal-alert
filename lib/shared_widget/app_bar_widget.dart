import 'package:criminal_alert/shared_widget/popUpMenu.dart';
import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return AppBar(
    title: Text('Criminal Alert'),
    backgroundColor: Colors.redAccent,
    actions: <Widget>[
      popupMenuButton(context)
    ],
  );
}