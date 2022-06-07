part of 'authentification_bloc.dart';

abstract class AuthentificationEvent extends Equatable {
  const AuthentificationEvent();

  @override
  List<Object> get props => [];
}

class AuthentificationWithPhoneNumber extends AuthentificationEvent {
  const AuthentificationWithPhoneNumber({
    required this.phoneNumber,
  });
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class ValidateOTPCode extends AuthentificationEvent {
  const ValidateOTPCode({
    required this.smsCode,
    required this.verificationID,
  });
  final String smsCode;
  final String verificationID;

  @override
  List<Object> get props => [
        smsCode,
        verificationID,
      ];
}

class AuthentificationWithGoogle extends AuthentificationEvent {}

class AuthentificationWithFacebook extends AuthentificationEvent {}

class AuthentificationWithAuthCredential extends AuthentificationEvent {
  const AuthentificationWithAuthCredential({
    required this.authCredential,
  });
  final AuthCredential authCredential;

  @override
  List<Object> get props => [authCredential];
}

class AuthentificationCreateNewUser extends AuthentificationEvent {
  const AuthentificationCreateNewUser({
    required this.userModel,
    required this.authCredential,
  });
  final UserModel userModel;
  final AuthCredential authCredential;

  @override
  List<Object> get props => [
        userModel,
        authCredential,
      ];
}

class AuthentificationError extends AuthentificationEvent {
  const AuthentificationError({
    required this.error,
  });
  final FirebaseAuthException error;

  @override
  List<Object> get props => [error];
}

class AuthentificationLinking extends AuthentificationEvent {
  const AuthentificationLinking({
    required this.newCredential,
    required this.oldCredential,
  });
  final AuthCredential oldCredential;
  final AuthCredential newCredential;

  @override
  List<Object> get props => [
        oldCredential,
        newCredential,
      ];
}
