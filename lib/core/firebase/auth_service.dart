import 'package:app/view_app/screens/auth/forgot_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> resetPasswordFromCurentPassword(String email, String password) async {
    try {
      await _firebaseAuth.currentUser?.updatePassword(password);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        return await _firebaseAuth.signInWithCredential(credential);
      }
    } catch (e) {
      return null;
    }
  }

  // Future<void> signInWithApple() async {
  //   final AppleSignIn appleSignIn = AppleSignIn();
  //   final AppleSignInResult appleSignInResult = await appleSignIn.signIn();
  // }

  // Future<void> signInWithFacebook() async {
  //   final FacebookLogin facebookLogin = FacebookLogin();
  //   final FacebookLoginResult facebookLoginResult = await facebookLogin.logIn();
  // }
}
