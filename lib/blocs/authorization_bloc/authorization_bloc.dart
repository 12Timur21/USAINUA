import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usainua/models/user_model.dart';
import 'package:usainua/repositories/auth_repository.dart';
import 'package:usainua/repositories/firestore_repository.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc() : super(const AuthorizationState()) {
    on<AppLoaded>((event, emit) async {
      String? uid = AuthRepository.instance.uid;
      UserModel? userModel;

      if (uid != null) {
        userModel = await FirestoreRepository.instance.getUserByUid(uid);
      }

      if (userModel != null) {
        emit(
          AuthorizationState(
            userModel: userModel,
            authorizationStatus: AuthorizationStatus.authenticated,
          ),
        );
      } else {
        emit(
          const AuthorizationState(
            authorizationStatus: AuthorizationStatus.unauthenticated,
          ),
        );
      }
    });
    on<UserLoggedIn>((event, emit) {
      emit(
        AuthorizationState(
          userModel: event.userModel,
          isNewUser: event.isNewUser,
          authorizationStatus: AuthorizationStatus.authenticated,
        ),
      );
    });
    on<UserLoggedOut>((event, emit) {
      emit(
        const AuthorizationState(
          authorizationStatus: AuthorizationStatus.unauthenticated,
        ),
      );
    });
    //Тут что-то не так
    on<UpdateUserModel>((event, emit) {
      emit(
        state.copyWith(
          userModel: event.userModel,
        ),
      );
    });
  }
}
