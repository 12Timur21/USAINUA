import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:usainua/blocs/authentication_bloc/authentification_bloc.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/welcome_page/welcome_page.dart';
import 'package:usainua/pages/auth_pages/widgets/buttons/nav_link_button.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/verification_code';

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  int _remainingTime = 24;
  final TextEditingController _otpController = TextEditingController();

  void _alreadySignUp() {
    //TODO Продумать
    Navigator.of(context).pop();
  }

  void _validateOTP() {
    AuthentificationState state = context.read<AuthentificationBloc>().state;
    if (state is AuthentificationCodeSend) {
      context.read<AuthentificationBloc>().add(
            ValidateOTPCode(
              smsCode: _otpController.text,
              verificationID: state.verificationId,
            ),
          );
    }

    // Navigator.of(context).pushNamed(
    //   WelcomePage.routeName,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocProvider.of<AuthentificationBloc>(context),
      child: BlocListener<AuthentificationBloc, AuthentificationState>(
        listener: (context, state) {
          print('call here  2');
          print(state);
          if (state is AuthentificationTimeOut) {}
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
                const Text(
                  'Смс с кодом отправленно на номер: +38 063 058 8512',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: AppFonts.bold,
                    fontSize: AppFonts.sizeSmall,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onSubmitted: (value) {
                    _validateOTP();
                  },
                  onCompleted: (value) {},
                  onChanged: (value) {
                    // print(value);
                    // setState(() {
                    //   currentText = value;
                    // });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  keyboardType: TextInputType.number,
                  // animationType: AnimationType.fade,
                  textStyle: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: AppFonts.regular,
                    fontSize: AppFonts.sizeXXXLarge,
                  ),
                  pinTheme: _pinTheme,
                  // animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,

                  // errorAnimationController: errorController,
                  controller: _otpController,
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
                      color: AppColors.textSecondary,
                      fontWeight: AppFonts.regular,
                      fontSize: AppFonts.sizeSmall,
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
                NavLinkButton(
                  onTap: _alreadySignUp,
                  text: 'Вернутся назад',
                  icon: SvgPicture.asset(
                    AppIcons.keyInBox,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final PinTheme _pinTheme = PinTheme(
  shape: PinCodeFieldShape.underline,
  borderRadius: BorderRadius.circular(5),
  inactiveFillColor: Colors.transparent,
  selectedFillColor: Colors.transparent,
  activeColor: AppColors.textPrimary,
  inactiveColor: AppColors.primary,
  selectedColor: AppColors.textPrimary,
  fieldHeight: 50,
  fieldWidth: 60,
  activeFillColor: Colors.white,
);
