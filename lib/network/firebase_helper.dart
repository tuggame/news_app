import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/const_lib/tr_consts.dart' as turkish;
import 'package:news_app/ui/component/toast_message.dart';

class FirebaseHelper {
  static FirebaseHelper _firebaseHelperInstance = FirebaseHelper._init();
  FirebaseAuth _firebaseAuth;

  static FirebaseHelper get helperInstance => _firebaseHelperInstance;

  FirebaseAuth get firebaseInstance => _firebaseHelperInstance._firebaseAuth;

  FirebaseHelper._init() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  static Future<void> createInstance() async {
    if (_firebaseHelperInstance._firebaseAuth == null) {
      _firebaseHelperInstance._firebaseAuth = FirebaseAuth.instance;
    }
  }

  Future<void> signUp(BuildContext context, String email, String password) async {
    try {
      final User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        ToastMessage(
          text: turkish.welcome,
        ).showToastMessage(context);

        await Future.delayed(const Duration(seconds: 1));

        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      } else {
        ToastMessage(
          text: turkish.something_wrongs,
        ).showToastMessage(context);
      }
    } on FirebaseAuthException catch (e) {
      // TODO: BU hatalari goster!
      if (e.code == 'weak-password') {
        debugPrint(turkish.weak_password);
        ToastMessage(
          text: turkish.weak_password,
        ).showToastMessage(context);
      } else if (e.code == 'email-already-in-use') {
        debugPrint(turkish.email_already_in_use);
        ToastMessage(
          text: turkish.email_already_in_use,
        ).showToastMessage(context);
      } else {
        ToastMessage(
          text: turkish.something_wrongs,
        ).showToastMessage(context);
      }
    } catch (e) {
      ToastMessage(
        text: turkish.something_wrongs,
      ).showToastMessage(context);
      debugPrint(e.toString());
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      if (user != null) {
        ToastMessage(
          text: turkish.welcome,
        ).showToastMessage(context);

        await Future.delayed(const Duration(seconds: 1));

        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      } else {
        ToastMessage(
          text: turkish.something_wrongs,
        ).showToastMessage(context);
      }
    } catch (e) {
      ToastMessage(
        text: turkish.something_wrongs,
      ).showToastMessage(context);
      debugPrint(e.toString());
    }
  }

  Future<void> signIn(BuildContext context, String email, String password) async {
    try {
      final User user = (await FirebaseHelper.helperInstance.firebaseInstance
              .signInWithEmailAndPassword(
                email: email,
                password: password,
              )
              .catchError((error) => {
                    ToastMessage(
                      text: getMessageFromErrorCode(error.toString()),
                    ).showToastMessage(context)
                  }))
          .user;
      if (user != null) {
        ToastMessage(
          text: turkish.welcome,
        ).showToastMessage(context);

        await Future.delayed(const Duration(seconds: 1));

        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      } else {
        ToastMessage(
          text: turkish.something_wrongs,
        ).showToastMessage(context);
      }
    } catch (e) {
      ToastMessage(
        text: turkish.something_wrongs,
      ).showToastMessage(context);
      debugPrint(e.toString());
    }
  }

  signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    if (await GoogleSignIn().isSignedIn()) {
      debugPrint('Google kullanıcısı!');
      await GoogleSignIn().disconnect();
      await GoogleSignIn().signOut();
    }

    ToastMessage(
      text: turkish.goodbye,
    ).showToastMessage(context);

    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (route) => false);
  }

  Future<void> sendResetPasswordMail(BuildContext context, String email) async {
    try {
      if (email.trim().isEmpty || !validateEmail(email)) {
        ToastMessage(text: turkish.invalid_email).showToastMessage(context);
      } else {
        await FirebaseHelper.helperInstance.firebaseInstance
            .sendPasswordResetEmail(email: email)
            .catchError((error) => {
                  ToastMessage(
                    text: getMessageFromErrorCode(error.toString()),
                  ).showToastMessage(context)
                });
        ToastMessage(text: turkish.forget_password_mail_done).showToastMessage(context);
      }
    } catch (e) {
      ToastMessage(
        text: turkish.something_wrongs,
      ).showToastMessage(context);
      debugPrint(e.toString());
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  void createUser(String email, String password) async {
    FirebaseHelper.helperInstance.firebaseInstance
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => {})
        .catchError((error) => {
              print(error.toString()),
            });
  }

  String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
      case "Wrong email/password combination.":
        return turkish.wrong_password;
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
      case "No user found with this email.":
        return turkish.user_not_found;
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No account found with this email";
        break;
      case "ERROR_INVALID_CUSTOM_TOKEN":
        return "The custom token format is incorrect. Please check the documentation.";
        break;
      case "ERROR_CUSTOM_TOKEN_MISMATCH":
        return "The custom token corresponds to a different audience.";
        break;
      case "ERROR_INVALID_CREDENTIAL":
        return "The supplied auth credential is malformed or has expired.";
        break;
      case "ERROR_INVALID_EMAIL":
        return "The email address is badly formatted.";
        break;
      case "ERROR_WRONG_PASSWORD":
        return "The password is invalid or the user does not have a password.";
        break;
      case "ERROR_USER_MISMATCH":
        return "The supplied credentials do not correspond to the previously signed in user.";
        break;
      case "ERROR_REQUIRES_RECENT_LOGIN":
        return "This operation is sensitive and requires recent authentication. Log in again before retrying this request.";
        break;
      case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
        return "An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.";
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "The email address is already in use by another account.";
        break;
      case "ERROR_CREDENTIAL_ALREADY_IN_USE":
        return "This credential is already associated with a different user account.";
        break;
      case "ERROR_USER_DISABLED":
        return "The user account has been disabled by an administrator.";
        break;
      case "ERROR_USER_TOKEN_EXPIRED":
        return "The user\\'s credential is no longer valid. The user must sign in again.";
        break;
      case "ERROR_USER_NOT_FOUND":
        return "There is no user record corresponding to this identifier. The user may have been deleted.";
        break;
      case "ERROR_INVALID_USER_TOKEN":
        return "The user\\'s credential is no longer valid. The user must sign in again.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "This operation is not allowed. You must enable this service in the console.";
        break;
      case "ERROR_WEAK_PASSWORD":
        return "The given password is invalid.";
        break;
      default:
        return turkish.something_wrongs;
        break;
    }
  }
}
