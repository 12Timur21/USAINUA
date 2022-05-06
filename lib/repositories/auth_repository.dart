import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:usainua/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository._();
  static final AuthRepository instance = AuthRepository._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumberAndSendOTP({
    required String phoneNumber,
    required void Function(PhoneAuthCredential authCredential)
        verificationCompleted,
    required void Function(FirebaseAuthException error) verificationFailed,
    required void Function(String verificationId, int? token) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    Duration timeout = const Duration(
      seconds: 30,
    ),
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+$phoneNumber',
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: timeout,
    );
  }

  PhoneAuthCredential verifyOTPCode({
    required String verificationID,
    required String smsCode,
  }) {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationID,
      smsCode: smsCode,
    );
    return phoneAuthCredential;
  }

  Future<void> signInWithPhoneAuthCredential(
    PhoneAuthCredential phoneAuthCredential,
  ) async {
    try {
      UserCredential result =
          await _auth.signInWithCredential(phoneAuthCredential);

      User? user = result.user;
      await user?.updateEmail('timur.sholokh@gmail.com');
      await user?.updateDisplayName('12312312312312eeee');
      print(user);
      print('123');

      // if (user == null) throw Exception('1 1 1');

      // String uid = user.uid;

      // DatabaseService.instance.recordNewUser(userModel);

    } on FirebaseAuthException catch (e) {
      //TODO validate
      return null;
    }
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    User? user = userCredential.user;
    print(user);
  }

  Future<UserCredential> signInWithFacebook() async {
    final facebook = FacebookLogin();
    FacebookLoginResult loginResult = await facebook.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    if (loginResult.status == FacebookLoginStatus.success) {
      try {
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        final UserCredential userCredential =
            await _auth.signInWithCredential(facebookCredential);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        throw FirebaseAuthException(
          code: e.code,
        );
      }
    }

    if (loginResult.status == FacebookLoginStatus.cancel) {
      throw Exception('Authorization canceled');
    }

    throw Exception(loginResult.error?.developerMessage);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
