import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medi_connect/src/home_page.dart';
import '../../widget/snackbar.dart';
import 'login_page.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LoginPage();
        }
      },
    );
  }

  signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
        return await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else if (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS) {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        showSnackBar(
            "Platform do not support login", context, Icons.error, Colors.red);
      }
    } catch (e) {
      showSnackBar("Something gone wrong!", context, Icons.error, Colors.red);
    }
  }

  signOut(BuildContext context) async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS) {
        await GoogleSignIn().signOut();
      }
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        showSnackBar(
            "Logged Out Successfully", context, Icons.done, Colors.green);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar("Something gone wrong!", context, Icons.error, Colors.red);
      }
    }
  }

  createUserWithEmailAndPassword(String name, String emailAddress,
      String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      if (context.mounted) {
        showSnackBar(
            "Account created successfully", context, Icons.done, Colors.green);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (context.mounted) {
          showSnackBar("The password provided is too weak.", context,
              Icons.error, Colors.red);
        }
      } else if (e.code == 'email-already-in-use') {
        if (context.mounted) {
          showSnackBar("The account already exists for that email.", context,
              Icons.error, Colors.red);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar("Something gone wrong!", context, Icons.error, Colors.red);
      }
    }
  }

  signInWithEmailAndPassword(
      String emailAddress, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (context.mounted) {
          showSnackBar("No user found for that email.", context, Icons.error,
              Colors.red);
        }
      } else if (e.code == 'wrong-password') {
        if (context.mounted) {
          showSnackBar("Wrong password provided for that user.", context,
              Icons.error, Colors.red);
        }
      }
    }
  }

  signOutWithoutSnackBar() async {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      await GoogleSignIn().signOut();
    }
    await FirebaseAuth.instance.signOut();
  }

  sendVerificationEmail(BuildContext context) async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    if (context.mounted) {
      showSnackBar(
          "Verification email send", context, Icons.done, Colors.green);
    }
  }

  passwordReset(String mail, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: mail);
      if (context.mounted) {
        showSnackBar(
            'Password reset link sent', context, Icons.done, Colors.green);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar('Something went wrong', context, Icons.error, Colors.red);
      }
    }
  }
}
