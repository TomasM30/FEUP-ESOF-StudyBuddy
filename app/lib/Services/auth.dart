import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  // verify email
  Future<Object?> verifyEmail() async {
    try{
      User? user = FirebaseAuth.instance.currentUser;
      if (!user!.emailVerified) {
        await user.sendEmailVerification();
      }
      return "Check you email for verification";
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.code;
    } catch (e) {
      print(e);
      return e;
    }
    return null;
  }

  // Register with email and password
  Future<Object?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return e.code;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return e.code;
      }
    } catch (e) {
      print(e);
      return e;
    }
    return null;
  }

  // Sign in with email and password
  Future<Object?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return e.code;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return e.code;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

// Change user email
  Future<String> changeEmail(String email) async {
    try {
      await FirebaseAuth.instance.currentUser?.verifyBeforeUpdateEmail(email);

      // Return a success message
      return "Email updated";
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Email is already in use by another account.";
      }
      return "Failed to update email";
    } catch (e) {
      return "Failed to update email";
    }
  }


  // Change user password
  Future<String?> changePassword({String? email}) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      String? emailToSend = email ?? user?.email;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailToSend!);
      return "Password updated";
    } catch (e) {
      print(e);
      return null;
    }
  }


  // Get the current user
  User? getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }
}
