import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Client {
  late User info;
  late bool googleUserIsSignedIn;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> setSignInStatus() async {
    googleUserIsSignedIn = await _googleSignIn.isSignedIn();
  }

  Future<void> signInUser() async {
    // Signing in with Google
    GoogleSignInAccount? googleUser = googleUserIsSignedIn
        ? await _googleSignIn.signInSilently()
        : await _googleSignIn.signIn();

    if (googleUser == null) throw new Exception('User sign in failed.');

    GoogleSignInAuthentication userAuthentication =
        await googleUser.authentication;

    OAuthCredential googleUserCredential = GoogleAuthProvider.credential(
        accessToken: userAuthentication.accessToken,
        idToken: userAuthentication.idToken);

    // Signing in with Firebase
    await _firebaseAuth.signInWithCredential(googleUserCredential);
    info = _firebaseAuth.currentUser!;

    await setSignInStatus();
  }

  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    await setSignInStatus();
  }
}
