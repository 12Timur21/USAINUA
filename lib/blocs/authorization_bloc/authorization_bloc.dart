import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usainua/models/user_model.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc() : super(AuthorizationInitial()) {
    on<AppLoaded>((event, emit) async {
      try {
        await Future.delayed(
          const Duration(
            milliseconds: 500,
          ),
        ); // a simulated delay
        UserModel? user = null;

        if (user != null) {
          emit(
            AuthorizationAuthenticated(
              user: user,
            ),
          );
        } else {
          emit(
            AuthorizationUnauthenticated(),
          );
        }
      } catch (e) {
        //TODO FIX
        emit(
          AuthorizationFailure(
            message: 'errorore',
            // message: e.toString() ?? 'An unknown error occurred',
          ),
        );
      }
    });
    on<UserLoggedIn>((event, emit) {
      emit(
        AuthorizationAuthenticated(
          user: event.user,
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
