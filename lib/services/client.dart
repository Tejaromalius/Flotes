import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Client {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? firebaseUser;
  OAuthCredential? googleUserCredential;
  bool googleUserIsSignedIn = false;

  Future<void> setSignInStatus() async {
    this.googleUserIsSignedIn = await googleSignIn.isSignedIn();
  }

  Future<void> signInUser() async {
    await _signInGoogle();
    await _signInFirebase();
  }

  Future<void> signOutUser() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
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
    await firebaseAuth.signInWithCredential(googleUserCredential!);
    firebaseUser = firebaseAuth.currentUser;
  }
}
