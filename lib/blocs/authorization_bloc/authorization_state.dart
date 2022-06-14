part of 'authorization_bloc.dart';

enum AuthorizationStatus {
  unauthenticated,
  authenticated,
}

class AuthorizationState extends Equatable {
  const AuthorizationState({
    this.userModel,
    this.authorizationStatus = AuthorizationStatus.unauthenticated,
    this.isNewUser = false,
  });
  final UserModel? userModel;
  final AuthorizationStatus authorizationStatus;
  final bool isNewUser;

  @override
  List<Object> get props => [
        authorizationStatus,
        isNewUser,
      ];
}
