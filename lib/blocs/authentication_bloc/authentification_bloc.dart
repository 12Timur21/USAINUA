import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:usainua/repositories/auth_repository.dart';

part 'authentification_event.dart';
part 'authentification_state.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  AuthentificationBloc() : super(AuthentificationInitial()) {
    on<SigninInWithPhoneNumber>((event, emit) {});
    on<SignUpWithPhoneNumber>((event, emit) async {
      const Duration timeOutDuration = Duration(seconds: 30);
      final Completer completer = Completer();

      await AuthRepository.instance.verifyPhoneNumberAndSendOTP(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential authCredential) {
          AuthRepository.instance.signInWithPhoneAuthCredential(
            authCredential,
          );
          emit(
            AuthentificationSuccess(),
          );
          completer.complete();
        },
        codeSent: (String verificationId, int? token) async {
          emit(AuthentificationCodeSend(
            verificationId: verificationId,
            token: token,
          ));
        },
        codeAutoRetrievalTimeout: (_) {
          print(3);
          emit(
            AuthentificationTimeOut(),
          );
          completer.complete();
        },
        verificationFailed: (FirebaseAuthException e) {
          print(4);
          //TODO сделать
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
            emit(
              AuthentificationFailure(error: e.code),
            );
          } else {
            print('какая-то другая ошибка.');
            emit(
              AuthentificationFailure(error: e.code),
            );
          }
          completer.complete();
        },
        timeout: timeOutDuration,
      );

      await completer.future;
    });
    on<ValidateOTPCode>((event, emit) async {
      PhoneAuthCredential authCredential =
          AuthRepository.instance.verifyOTPCode(
        verificationID: event.verificationID,
        smsCode: event.smsCode,
      );

      AuthRepository.instance.signInWithPhoneAuthCredential(
        authCredential,
      );
    });
    on<AuthentificationWithGoogle>((event, emit) async {
      AuthRepository.instance.signInWithGoogle();
    });
    on<AuthentificationWithFacebook>((event, emit) async {
      //TODO !@!
      try {
        UserCredential userCredential =
            await AuthRepository.instance.signInWithFacebook();
        print('1112323232');
        print(userCredential.user);
      } catch (error) {
        add(AuthentificationErrorHandling(
          error: error,
        ));
      }
    });

    on<AuthentificationErrorHandling>((event, emit) {
      late String messageError;
      switch (event.error) {
        case 'Authorization canceled':
          messageError = 'Авторизация отменена';
          break;
        default:
          messageError = 'Неизвестная ошибка';
      }
      emit(
        AuthentificationFailure(
          error: messageError,
        ),
      );
    });
  }
}
