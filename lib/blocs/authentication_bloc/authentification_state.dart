part of 'authentification_bloc.dart';

abstract class AuthentificationState extends Equatable {
  const AuthentificationState();

  @override
  List<Object> get props => [];
}

class AuthentificationInitial extends AuthentificationState {}

class AuthentificationCodeSend extends AuthentificationState {
  final String verificationId;
  final int? token;

  const AuthentificationCodeSend({
    required this.verificationId,
    required this.token,
  });

  @override
  List<Object> get props => [verificationId];
}

class SocialNetworksNeedMoreData extends AuthentificationState {
  final UserModel userModel;
  final AuthCredential authCredential;
  const SocialNetworksNeedMoreData({
    required this.userModel,
    required this.authCredential,
  });

  @override
  List<Object> get props => [
        userModel,
        authCredential,
      ];
}

class AuthentificationSuccess extends AuthentificationState {
  final UserModel userModel;
  final bool isNewUser;

  const AuthentificationSuccess({
    required this.userModel,
    this.isNewUser = false,
  });

  @override
  List<Object> get props => [
        userModel,
        isNewUser,
      ];
}

class AuthentificationFailure extends AuthentificationState {
  final String error;

  const AuthentificationFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ValidationOTPSuccess extends AuthentificationState {
  final AuthCredential authCredential;

  const ValidationOTPSuccess({
    required this.authCredential,
  });

  @override
  List<Object> get props => [authCredential];
}

class ValidationOTPFailed extends AuthentificationState {
  final String error;

  const ValidationOTPFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ValidationOTPTimeOut extends AuthentificationState {}

class AuthentificationWithTheSameCredential extends AuthentificationState {
  final AuthCredential authCredential;
  final AuthType authType;

  const AuthentificationWithTheSameCredential({
    required this.authCredential,
    required this.authType,
  });

  @override
  List<Object> get props => [
        authCredential,
        authType,
      ];
}
