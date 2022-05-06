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

class AuthentificationTimeOut extends AuthentificationState {}

class AuthentificationSuccess extends AuthentificationState {}

class AuthentificationFailure extends AuthentificationState {
  final String error;

  const AuthentificationFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
