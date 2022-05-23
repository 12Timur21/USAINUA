part of 'authentification_bloc.dart';

abstract class AuthentificationEvent extends Equatable {
  const AuthentificationEvent();

  @override
  List<Object> get props => [];
}

class AuthentificationWithPhoneNumber extends AuthentificationEvent {
  final String phoneNumber;

  const AuthentificationWithPhoneNumber({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class ValidateOTPCode extends AuthentificationEvent {
  final String smsCode;
  final String verificationID;

  const ValidateOTPCode({
    required this.smsCode,
    required this.verificationID,
  });

  @override
  List<Object> get props => [
        smsCode,
        verificationID,
      ];
}

class AuthentificationWithGoogle extends AuthentificationEvent {}

class AuthentificationWithFacebook extends AuthentificationEvent {}

class AuthentificationWithAuthCredential extends AuthentificationEvent {
  final AuthCredential authCredential;

  const AuthentificationWithAuthCredential({
    required this.authCredential,
  });

  @override
  List<Object> get props => [authCredential];
}

class AuthentificationCreateNewUser extends AuthentificationEvent {
  final UserModel userModel;
  final AuthCredential authCredential;

  const AuthentificationCreateNewUser({
    required this.userModel,
    required this.authCredential,
  });

  @override
  List<Object> get props => [
        userModel,
        authCredential,
      ];
}

class AuthentificationError extends AuthentificationEvent {
  final FirebaseAuthException error;

  const AuthentificationError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class AuthentificationLinking extends AuthentificationEvent {
  final AuthCredential oldCredential;
  final AuthCredential newCredential;

  const AuthentificationLinking({
    required this.newCredential,
    required this.oldCredential,
  });

  @override
  List<Object> get props => [
        oldCredential,
        newCredential,
      ];
}
