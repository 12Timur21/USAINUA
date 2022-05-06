part of 'authentification_bloc.dart';

abstract class AuthentificationEvent extends Equatable {
  const AuthentificationEvent();

  @override
  List<Object> get props => [];
}

class SigninInWithPhoneNumber extends AuthentificationEvent {
  final String phoneNumber;

  const SigninInWithPhoneNumber({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class SignUpWithPhoneNumber extends AuthentificationEvent {
  final String name;
  final String email;
  final String phoneNumber;

  const SignUpWithPhoneNumber({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [name, email, phoneNumber];
}

class ValidateOTPCode extends AuthentificationEvent {
  final String smsCode;
  final String verificationID;

  const ValidateOTPCode({
    required this.smsCode,
    required this.verificationID,
  });

  @override
  List<Object> get props => [smsCode, verificationID];
}

class AuthentificationWithGoogle extends AuthentificationEvent {}

class AuthentificationWithFacebook extends AuthentificationEvent {}

class AuthentificationErrorHandling extends AuthentificationEvent {
  final Object error;

  const AuthentificationErrorHandling({
    required this.error,
  });
}
