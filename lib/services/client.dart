import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Client {
  GoogleSignIn googleSignIn = GoogleSignIn();

  User? firebaseUser;
  OAuthCredential? googleUserCredential;
  bool googleUserIsSignedIn = false;

  Future<void> setSignInStatus() async {
    googleUserIsSignedIn = await googleSignIn.isSignedIn();
    print('Google user is signed in: $googleUserIsSignedIn');
  }

  Future<void> signInUser() async {
    await _signInGoogle();
    await _signInFirebase();
    await setSignInStatus();
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    await setSignInStatus();
  }

  Future<void> _signInGoogle() async {
    GoogleSignInAccount? googleUser = this.googleUserIsSignedIn
        ? await googleSignIn.signInSilently()
        : await googleSignIn.signIn();

    if (googleUser == null) throw new Exception('User sign in failed.');

    GoogleSignInAuthentication userAuthentication =
        await googleUser.authentication;
    googleUserCredential = GoogleAuthProvider.credential(
      accessToken: userAuthentication.accessToken,
      idToken: userAuthentication.idToken,
    );
  }

  Future<void> _signInFirebase() async {
    await FirebaseAuth.instance.signInWithCredential(googleUserCredential!);
    firebaseUser = FirebaseAuth.instance.currentUser;
  }
}
