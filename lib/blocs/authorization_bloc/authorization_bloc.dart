import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usainua/models/user_model.dart';
import 'package:usainua/repositories/auth_repository.dart';
import 'package:usainua/repositories/firestore_repository.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc() : super(AuthorizationInitial()) {
    on<AppLoaded>((event, emit) async {
      String? uid = AuthRepository.instance.uid;
      UserModel? userModel;

      if (uid != null) {
        userModel = await FirestoreRepository.instance.getUserByUid(uid);
      }

      if (userModel != null) {
        emit(
          AuthorizationAuthenticated(
            user: userModel,
          ),
        );
      } else {
        emit(
          AuthorizationUnauthenticated(),
        );
      }
    });
    on<UserLoggedIn>((event, emit) {
      emit(
        AuthorizationAuthenticated(
          user: event.userModel,
          isNewUser: event.isNewUser,
        ),
      );
    });
    on<UserLoggedOut>((event, emit) {
      emit(
        AuthorizationUnauthenticated(),
      );
    });
  }
}
