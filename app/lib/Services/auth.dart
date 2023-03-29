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
      return null;
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
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return "User not signed in.";
    }
    try {
      if(user.email == email) {
        return "That is already your email.";
      }
      await user.updateEmail(email);
      return "Email updated";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.code;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }




  // Get the current user
  User? getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }
}
