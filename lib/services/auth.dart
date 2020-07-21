
import 'package:criminal_alert/location/storeUserLocation.dart';
import 'package:criminal_alert/model/firebase_user.dart';
import 'package:criminal_alert/notification/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  User firebaseUserCustomized(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(firebaseUserCustomized);
  }

  Future signInWithGoogle() async {
    try {
          GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
        if (googleAccount == null) {
          print('no account');
          return null;
        }
        GoogleSignInAuthentication googleSignInAuth =
            await googleAccount.authentication;
        AuthCredential authCredential = GoogleAuthProvider.getCredential(
            idToken: googleSignInAuth.idToken,
            accessToken: googleSignInAuth.accessToken);
        AuthResult result = await _auth.signInWithCredential(authCredential);
        FirebaseUser user = result.user;
        await PhoneToken(uid: user.uid).phoneToken();
        firebaseUserCustomized(user);

        print(user.email.toString());
        print(user.displayName.toString());

    } catch (error) {
      print(error.toString());
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      print('Signed Out');
    } catch (error) {
      print(error.toString());
    }
  }
}
