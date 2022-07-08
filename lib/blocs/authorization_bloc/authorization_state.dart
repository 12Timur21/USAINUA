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

  AuthorizationState copyWith({
    UserModel? userModel,
    AuthorizationStatus? authorizationStatus,
    bool? isNewUser,
  }) {
    return AuthorizationState(
      userModel: userModel ?? this.userModel,
      authorizationStatus: authorizationStatus ?? this.authorizationStatus,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }

  @override
  List<Object> get props => [
        authorizationStatus,
        isNewUser,
      ];
}
