import 'package:criminal_alert/services/auth.dart';
import 'package:criminal_alert/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Criminal Alert',
        theme: ThemeData(
          primaryColor: Colors.redAccent
        ),
        home: Wrapper(),
      ),
    );
  }
}
