part of 'authentification_bloc.dart';

abstract class AuthentificationState extends Equatable {
  const AuthentificationState();

  @override
  List<Object> get props => [];
}

class AuthentificationInitial extends AuthentificationState {}

class AuthentificationCodeSend extends AuthentificationState {
  const AuthentificationCodeSend({
    required this.verificationId,
    required this.token,
  });
  final String verificationId;
  final int? token;

  @override
  List<Object> get props => [verificationId];
}

class SocialNetworksNeedMoreData extends AuthentificationState {
  const SocialNetworksNeedMoreData({
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

class AuthentificationSuccess extends AuthentificationState {
  const AuthentificationSuccess({
    required this.userModel,
    this.isNewUser = false,
  });
  final UserModel userModel;
  final bool isNewUser;

  @override
  List<Object> get props => [
        userModel,
        isNewUser,
      ];
}

class AuthentificationFailure extends AuthentificationState {
  const AuthentificationFailure({
    required this.error,
  });
  final String error;

  @override
  List<Object> get props => [error];
}

class ValidationOTPSuccess extends AuthentificationState {
  const ValidationOTPSuccess({
    required this.authCredential,
  });
  final AuthCredential authCredential;

  @override
  List<Object> get props => [authCredential];
}

class ValidationOTPFailed extends AuthentificationState {
  const ValidationOTPFailed({
    required this.error,
  });
  final String error;

  @override
  List<Object> get props => [error];
}

class ValidationOTPTimeOut extends AuthentificationState {}

class AuthentificationWithTheSameCredential extends AuthentificationState {
  const AuthentificationWithTheSameCredential({
    required this.authCredential,
    required this.authType,
  });
  final AuthCredential authCredential;
  final AuthType authType;

  @override
  List<Object> get props => [
        authCredential,
        authType,
      ];
}
