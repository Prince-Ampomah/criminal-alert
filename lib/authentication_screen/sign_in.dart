import 'package:criminal_alert/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthServices _authServices = AuthServices();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            isLoading
                ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),))
                : Center(child: Text('')),
            SizedBox(
              height: 20,
            ),
            Center(
                child: GoogleSignInButton(
                    onPressed: () async {
                      setState(() => isLoading = true);
                      dynamic result = await _authServices.signInWithGoogle();
                      if (result != null) {
                        print('Logged In');
                        setState(() => isLoading = false);
                      }
                    },
                    darkMode: true,
                    splashColor: Colors.redAccent,
                    borderRadius: 5.0)),
          ],
        ),
      ),
    );
  }
}
