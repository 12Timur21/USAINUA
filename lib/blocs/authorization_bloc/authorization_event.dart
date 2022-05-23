part of 'authorization_bloc.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthorizationEvent {}

class UserLoggedIn extends AuthorizationEvent {
  final UserModel userModel;
  final bool isNewUser;

  const UserLoggedIn({
    required this.userModel,
    this.isNewUser = false,
  });

  @override
  List<Object> get props => [userModel];
}

class UserLoggedOut extends AuthorizationEvent {}
