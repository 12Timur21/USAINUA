import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:usainua/models/user_model.dart';
import 'package:usainua/pages/auth_pages/credential_linking_page/credential_linking_page.dart';
import 'package:usainua/repositories/auth_repository.dart';
import 'package:usainua/repositories/firestore_repository.dart';
part 'authentification_event.dart';
part 'authentification_state.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  AuthentificationBloc() : super(AuthentificationInitial()) {
    final AuthRepository _auth = AuthRepository.instance;

    on<AuthentificationWithPhoneNumber>((event, emit) async {
      const Duration timeOutDuration = Duration(seconds: 30);
      final Completer completer = Completer();

      await _auth.verifyPhoneNumberAndSendOTP(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (_) {},
        codeSent: (String verificationId, int? token) async {
          emit(
            AuthentificationCodeSend(
              verificationId: verificationId,
              token: token,
            ),
          );
        },
        codeAutoRetrievalTimeout: (_) {
          emit(
            ValidationOTPTimeOut(),
          );
          completer.complete();
        },
        verificationFailed: (FirebaseAuthException e) {
          add(
            AuthentificationError(
              error: e,
            ),
          );
          completer.complete();
        },
        timeout: timeOutDuration,
      );

      await completer.future;
    });

    on<ValidateOTPCode>((event, emit) async {
      try {
        PhoneAuthCredential authCredential = _auth.verifyOTPCode(
          verificationID: event.verificationID,
          smsCode: event.smsCode,
        );

        emit(
          ValidationOTPSuccess(
            authCredential: authCredential,
          ),
        );
      } on FirebaseAuthException catch (e) {
        add(
          AuthentificationError(
            error: e,
          ),
        );
      }
    });

    on<AuthentificationWithGoogle>((event, emit) async {
      try {
        final AuthCredential authCredential = await _auth.signInWithGoogle();

        add(
          AuthentificationWithAuthCredential(
            authCredential: authCredential,
          ),
        );
      } on FirebaseAuthException catch (e) {
        add(
          AuthentificationError(
            error: e,
          ),
        );
      }
    });

    on<AuthentificationWithFacebook>((event, emit) async {
      try {
        final AuthCredential authCredential = await _auth.signInWithFacebook();

        add(
          AuthentificationWithAuthCredential(
            authCredential: authCredential,
          ),
        );
      } on FirebaseAuthException catch (e) {
        add(
          AuthentificationError(
            error: e,
          ),
        );
      }
    });

    on<AuthentificationWithAuthCredential>((event, emit) async {
      try {
        UserCredential userCredential = await _auth.signInWithAuthCredential(
          event.authCredential,
        );
        User? user = userCredential.user;

        if (user != null) {
          UserModel? userModel =
              await FirestoreRepository.instance.getUserByUid(
            user.uid,
          );

          if (userModel != null) {
            emit(
              AuthentificationSuccess(
                userModel: userModel,
                isNewUser: false,
              ),
            );
          } else {
            await user.delete();
            emit(
              SocialNetworksNeedMoreData(
                authCredential: event.authCredential,
                userModel: UserModel(
                  uid: user.uid,
                  name: user.displayName,
                  email: user.email,
                  phoneNumber: user.phoneNumber,
                ),
              ),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          late AuthType authType = AuthType.phone;

          switch (event.authCredential.signInMethod) {
            case 'google.com':
              authType = AuthType.google;
              break;
            case 'facebook.com':
              authType = AuthType.facebook;
              break;
          }

          emit(
            AuthentificationWithTheSameCredential(
              authCredential: event.authCredential,
              authType: authType,
            ),
          );
        } else {
          add(
            AuthentificationError(
              error: e,
            ),
          );
        }
      }
    });

    on<AuthentificationCreateNewUser>((event, emit) async {
      User? user;
      try {
        UserCredential userCredential = await _auth.signInWithAuthCredential(
          event.authCredential,
        );
        user = userCredential.user;

        if (user != null) {
          UserModel? userModel =
              await FirestoreRepository.instance.getUserByUid(
            user.uid,
          );
          if (userModel != null) {
            emit(
              AuthentificationSuccess(
                userModel: userModel,
                isNewUser: false,
              ),
            );
          } else {
            await user.updateEmail(event.userModel.email!);
            await user.updateDisplayName(event.userModel.name);

            UserModel newUserModel = event.userModel.copyWith(
              uid: user.uid,
            );
            await FirestoreRepository.instance.createUser(newUserModel);

            emit(
              AuthentificationSuccess(
                userModel: newUserModel,
                isNewUser: true,
              ),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          late AuthType authType = AuthType.phone;

          switch (event.authCredential.signInMethod) {
            case 'google.com':
              authType = AuthType.google;
              break;
            case 'facebook.com':
              authType = AuthType.facebook;
              break;
          }

          user?.delete();
          emit(
            AuthentificationWithTheSameCredential(
              authCredential: event.authCredential,
              authType: authType,
            ),
          );
        } else {
          add(
            AuthentificationError(
              error: e,
            ),
          );
        }
      }
    });

    on<AuthentificationError>((event, emit) async {
      final String response = await rootBundle.loadString(
        'assets/jsons/firebase_errors.json',
      );
      Map<String, dynamic> data = await json.decode(response);

      String? errorMessage = data[event.error.code];
      emit(
        AuthentificationFailure(
          error: errorMessage ?? 'Неизвестная ошибка',
        ),
      );
    });

    on<AuthentificationLinking>((event, emit) async {
      try {
        UserCredential userCredential = await _auth.signInWithAuthCredential(
          event.oldCredential,
        );
        User? user = userCredential.user;

        if (user != null) {
          _auth.linkCredentials(
            user: user,
            authCredential: event.newCredential,
          );

          UserModel? userModel =
              await FirestoreRepository.instance.getUserByUid(
            user.uid,
          );

          if (userModel != null) {
            emit(
              AuthentificationSuccess(
                userModel: userModel,
              ),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        add(
          AuthentificationError(
            error: e,
          ),
        );
      }
    });
  }
}
