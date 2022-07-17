import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/blocs/authentication_bloc/authentification_bloc.dart';
import 'package:usainua/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:usainua/pages/auth_pages/verification_code_page/verification_code_page.dart';
import 'package:usainua/pages/main_page.dart';
import 'package:usainua/repositories/auth_repository.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/helpers/in_app_notification.dart';
import 'package:usainua/utils/validators/phone_validator.dart';
import 'package:usainua/widgets/buttons/service_auth_button.dart';
import 'package:usainua/widgets/text/rich_text_wrapper.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';

enum AuthType {
  phone,
  google,
  facebook,
}

class CredentialLinkingPageParameters {
  const CredentialLinkingPageParameters({
    required this.authType,
    required this.mainAuthCredential,
  });
  final AuthType authType;
  final AuthCredential mainAuthCredential;
}

class CredentialLinkingPage extends StatefulWidget {
  const CredentialLinkingPage({
    required this.parameters,
    Key? key,
  }) : super(key: key);

  static const routeName = '/credential_linking_page';

  final CredentialLinkingPageParameters parameters;

  @override
  State<CredentialLinkingPage> createState() => _CredentialLinkingPageState();
}

class _CredentialLinkingPageState extends State<CredentialLinkingPage> {
  final AuthRepository _auth = AuthRepository.instance;

  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPageLoading = false;

  Future<void> _phoneLinking() async {
    bool isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      String phoneNumber = toNumericString(
        _phoneController.text,
      );
      context.read<AuthentificationBloc>().add(
            AuthentificationWithPhoneNumber(
              phoneNumber: phoneNumber,
            ),
          );
    }
  }

  Future<void> _googleLinking() async {
    AuthCredential googleAuthCredential = await _auth.signInWithGoogle();
    context.read<AuthentificationBloc>().add(
          AuthentificationLinking(
            oldCredential: googleAuthCredential,
            newCredential: widget.parameters.mainAuthCredential,
          ),
        );
  }

  Future<void> _facebookLinking() async {
    AuthCredential facebookAuthCredential = await _auth.signInWithFacebook();
    if (!mounted) return;
    context.read<AuthentificationBloc>().add(
          AuthentificationLinking(
            oldCredential: facebookAuthCredential,
            newCredential: widget.parameters.mainAuthCredential,
          ),
        );
  }

  void _onBackAreaPressed() {
    Navigator.of(context).pop();
  }

  Future<void> _onCodeSend({
    required String verificationID,
  }) async {
    AuthCredential? phoneAuthCredential = await Navigator.of(context).pushNamed(
      VerificationCodePage.routeName,
      arguments: VerificationCodePageParameters(
        phoneNumber: toNumericString(
          _phoneController.text,
        ),
        verificationID: verificationID,
      ),
    ) as AuthCredential?;

    if (phoneAuthCredential != null) {
      setState(() {
        _isPageLoading = true;
      });
      context.read<AuthentificationBloc>().add(
            AuthentificationLinking(
              newCredential: widget.parameters.mainAuthCredential,
              oldCredential: phoneAuthCredential,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthentificationBloc, AuthentificationState>(
      listener: (context, state) {
        if (state is AuthentificationSuccess) {
          context.read<AuthorizationBloc>().add(
                UserLoggedIn(
                  userModel: state.userModel,
                  isNewUser: state.isNewUser,
                ),
              );
          Navigator.of(context).pushNamedAndRemoveUntil(
            MainPage.routeName,
            (route) => false,
          );
        }

        if (state is AuthentificationFailure) {
          InAppNotification.show(
            title: state.error,
            type: InAppNotificationType.error,
          );
        }

        if (state is AuthentificationCodeSend) {
          _onCodeSend(
            verificationID: state.verificationId,
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onTap: _onBackAreaPressed,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.scaffold,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Аккаунт уже существует с указаным email адресом',
                          style: TextStyle(
                            fontWeight: AppFonts.heavy,
                            fontSize: AppFonts.sizeXSmall,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Для дальнейшего входа, необходимо прикрепить его с ранее авторизованным аккаунтом',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // if (parameters.authType != AuthType.phone)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Через номер телефона',
                              style: TextStyle(
                                fontWeight: AppFonts.bold,
                                fontSize: AppFonts.sizeXSmall,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: _formKey,
                              child: TextFieldWithCustomLabel(
                                controller: _phoneController,
                                textInputAction: TextInputAction.done,
                                hintText: 'Ваш номер телефона*',
                                keyboardType: TextInputType.phone,
                                onSubmitted: (_) {
                                  _phoneLinking();
                                },
                                formatters: [
                                  PhoneInputFormatter(),
                                ],
                                validator: MultiValidator([
                                  MinLengthValidator(
                                    1,
                                    errorText: 'Укажите номер телефона',
                                  ),
                                  PhoneValidator(
                                    errorText:
                                        'Укажите корректный номер телефона',
                                  ),
                                ]),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _phoneLinking,
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                child: const Text(
                                  'Cвязать с телефоном',
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const Divider(
                                  height: 40,
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Container(
                                  color: Colors.white,
                                  child: const Text(
                                    'ИЛИ',
                                    style: TextStyle(
                                      color: AppColors.darkBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        RichTextWrapper(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textStyle: const TextStyle(
                            color: AppColors.darkBlue,
                            fontWeight: AppFonts.regular,
                            fontSize: AppFonts.sizeXSmall,
                            letterSpacing: 1,
                          ),
                          children: [
                            if (widget.parameters.authType != AuthType.google)
                              ServiceAuthButton(
                                text: 'Cвязать с Google',
                                icon: SvgPicture.asset(AppIcons.google),
                                onTap: _googleLinking,
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (widget.parameters.authType != AuthType.facebook)
                              ServiceAuthButton(
                                text: 'Cвязать с Facebook',
                                icon: SvgPicture.asset(AppIcons.facebook),
                                onTap: _facebookLinking,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_isPageLoading)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
