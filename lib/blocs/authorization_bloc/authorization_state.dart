part of 'authorization_bloc.dart';

abstract class AuthorizationState extends Equatable {
  const AuthorizationState();

  @override
  List<Object> get props => [];
}

class AuthorizationInitial extends AuthorizationState {}

class AuthorizationLoading extends AuthorizationState {}

class AuthorizationUnauthenticated extends AuthorizationState {}

class AuthorizationAuthenticated extends AuthorizationState {
  final UserModel user;
  final bool isNewUser;

  const AuthorizationAuthenticated({
    required this.user,
    this.isNewUser = false,
  });

  @override
  List<Object> get props => [user];
}

class AuthorizationFailure extends AuthorizationState {
  final String message;

  const AuthorizationFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
