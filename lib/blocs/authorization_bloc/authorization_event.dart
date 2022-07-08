part of 'authorization_bloc.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthorizationEvent {}

class UserLoggedIn extends AuthorizationEvent {
  const UserLoggedIn({
    required this.userModel,
    this.isNewUser = false,
  });
  final UserModel userModel;
  final bool isNewUser;

  @override
  List<Object> get props => [userModel];
}

class UpdateUserModel extends AuthorizationEvent {
  const UpdateUserModel({
    required this.userModel,
  });
  final UserModel userModel;

  @override
  List<Object> get props => [userModel];
}

class UserLoggedOut extends AuthorizationEvent {}
