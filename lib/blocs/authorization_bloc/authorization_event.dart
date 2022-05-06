part of 'authorization_bloc.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthorizationEvent {}

class UserLoggedIn extends AuthorizationEvent {
  final UserModel user;

  const UserLoggedIn({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class UserLoggedOut extends AuthorizationEvent {}
