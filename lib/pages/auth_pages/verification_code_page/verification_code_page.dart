import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:usainua/blocs/authentication_bloc/authentification_bloc.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/helpers/in_app_notification.dart';
import 'package:usainua/widgets/buttons/icon_text_button.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';

class VerificationCodePageParameters {
  const VerificationCodePageParameters({
    required this.phoneNumber,
    required this.verificationID,
  });

  final String phoneNumber;
  final String verificationID;
}

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({
    required this.parameters,
    Key? key,
  }) : super(key: key);

  static const routeName = '/verification_code';

  final VerificationCodePageParameters parameters;

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  int _remainingTime = 30;
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late Timer _timer;
  void _screenBelow() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (timer) {
        setState(() {
          _remainingTime--;
        });
        if (timer.tick == 30) timer.cancel();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  void _validateOTP() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthentificationBloc>().add(
            ValidateOTPCode(
              smsCode: _otpController.text,
              verificationID: widget.parameters.verificationID,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthentificationBloc, AuthentificationState>(
      listener: (context, state) {
        if (state is ValidationOTPSuccess) {
          Navigator.pop(
            context,
            state.authCredential,
          );
        }
        if (state is ValidationOTPTimeOut) {
          InAppNotification.show(
            title: 'Время регистрации вышло',
            type: InAppNotificationType.error,
          );

          Navigator.pop(context);
        }
        if (state is ValidationOTPFailed) {
          InAppNotification.show(
            title: state.error,
            type: InAppNotificationType.error,
          );
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Код подтверждения',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.070,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                'Смс с кодом отправленно на номер: +${widget.parameters.phoneNumber}',
                style: const TextStyle(
                  color: AppColors.lightBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeSmall,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onSubmitted: (value) {
                    _validateOTP();
                  },
                  validator: MinLengthValidator(
                    6,
                    errorText: 'Укажите код с смс',
                  ),
                  autovalidateMode: AutovalidateMode.disabled,
                  onChanged: (_) {},

                  keyboardType: TextInputType.number,

                  // animationType: AnimationType.fade,
                  textStyle: const TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: AppFonts.regular,
                    fontSize: AppFonts.sizeXLarge,
                  ),
                  pinTheme: _pinTheme(context),

                  // animationDuration: Duration(milliseconds: 300),

                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,

                  controller: _otpController,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SubmitButton(
                onTap: _validateOTP,
                text: 'ПРОВЕРИТЬ',
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: AppFonts.regular,
                    fontSize: AppFonts.sizeXSmall,
                    letterSpacing: 1,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Отправить код повторно через: '),
                    TextSpan(
                      text: _remainingTime.toString(),
                      style: const TextStyle(
                        fontWeight: AppFonts.extraBold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              IconTextButton(
                onTap: _screenBelow,
                text: 'Вернутся назад',
                textStyle: const TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeXSmall,
                  letterSpacing: 1,
                ),
                icon: SvgPicture.asset(
                  AppIcons.keyInBox,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

PinTheme _pinTheme(BuildContext context) {
  return PinTheme(
    shape: PinCodeFieldShape.underline,
    borderRadius: BorderRadius.circular(5),
    inactiveFillColor: Colors.transparent,
    selectedFillColor: Colors.transparent,
    activeColor: AppColors.darkBlue,
    inactiveColor: AppColors.primary,
    selectedColor: AppColors.darkBlue,
    fieldHeight: 50,
    fieldWidth: MediaQuery.of(context).size.width / 6 - 20,
    activeFillColor: Colors.white,
  );
}
