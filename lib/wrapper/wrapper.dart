import 'package:criminal_alert/authentication_screen/sign_in.dart';
import 'package:criminal_alert/home_page/home_page.dart';
import 'package:criminal_alert/model/firebase_user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
 /*    return StreamBuilder(
       stream: FirebaseAuth.instance.onAuthStateChanged,
       builder: (context, AsyncSnapshot<FirebaseUser> snapshot){
         if(snapshot.connectionState == ConnectionState.waiting)
           return LoadingScreen();
         if(!snapshot.hasData || snapshot.data == null)
         return SignIn();
       return HomePage();
       },
      
     );*/

    final user = Provider.of<User>(context);
    print(user.toString());

    if(user == null){
      return SignIn();
    }
    else{
      return HomePage();
    }
  }
}