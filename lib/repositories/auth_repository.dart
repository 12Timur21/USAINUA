import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository._();
  static final AuthRepository instance = AuthRepository._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get uid => _auth.currentUser?.uid;

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

  Future<UserCredential> signInWithAuthCredential(
    AuthCredential authCredential,
  ) async {
    return await _auth.signInWithCredential(authCredential);
  }

  Future<AuthCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleAccount?.authentication;

    final AuthCredential googleCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    return googleCredential;
  }

  Future<AuthCredential> signInWithFacebook() async {
    final FacebookLogin facebook = FacebookLogin();

    FacebookLoginResult loginResult = await facebook.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    if (loginResult.status == FacebookLoginStatus.success) {
      final AuthCredential facebookCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      return facebookCredential;
    }

    if (loginResult.status == FacebookLoginStatus.cancel) {
      throw FirebaseAuthException(
        message: 'Authorization canceled',
        code: 'auth-canseled',
      );
    }

    throw Exception(loginResult.error?.developerMessage);
  }

  Future<void> linkCredentials({
    required User user,
    required AuthCredential authCredential,
  }) async {
    user.linkWithCredential(authCredential);
  }

  bool isUserExists() {
    return _auth.currentUser == null ? false : true;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential> authWithPhone() async {
    ConfirmationResult res = await _auth.signInWithPhoneNumber('380969596645');
    return await res.confirm('111111');
  }

  Future<void> deleteUser() async {
    await _auth.currentUser?.delete();
  }
}
