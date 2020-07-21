import 'package:criminal_alert/internet_connection/internetConnectivity.dart';
import 'package:criminal_alert/services/auth.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
            Expanded(
              flex: 5,
              child: Container(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'CRIMINAL ALERT',
                        style: TextStyle(
                            fontSize: 26.0,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: <Widget>[
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ))
                        : Center(child: Text('')),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: GoogleSignInButton(
                            onPressed: () async {
                              setState(() => isLoading = true);
                              dynamic result =
                                  await _authServices.signInWithGoogle();
                              if (result != null) {
                                print('Logged In');
                                setState(() => isLoading = false);
                              } else {
                                setState(() => isLoading = false);
                              }
                              DataConnectionStatus status =
                                  await checkInternetConnection();
                              if (status == DataConnectionStatus.disconnected) {
                                FlutterToast.showToast(
                                    msg: "network error!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.redAccent,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                setState(() => isLoading = false);
                              }
                            },
                            darkMode: true,
                            splashColor: Colors.white,
                            borderRadius: 5.0)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
