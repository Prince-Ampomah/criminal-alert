import 'package:criminal_alert/loadingscreen/loadingScreen.dart';
import 'package:criminal_alert/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  AuthServices _authServices = AuthServices();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading? LoadingScreen():SafeArea(
          child: Scaffold(
          body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
                backgroundColor: Colors.white10,
                backgroundImage: AssetImage('assets/images/google.png'),
                radius: 30.0,
            ),
            SizedBox(height: 20,),
            Center(
                  child: RaisedButton(
                  onPressed: () async{
                    setState(() => isLoading = true);
                  dynamic result = await _authServices.signInWithGoogle();
                     if(result != null){
                   print('Logged In');
                  //  signInSnackbar();
                   setState(() => isLoading = false);
                   }
                  },
                  child: Text('Sign In', style: TextStyle(color: Colors.white),),
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(5)),
                  color: Colors.redAccent,
                  elevation: 10.0,
                    ),
                ),
          ],
        ),
              ),
      );
  }
}