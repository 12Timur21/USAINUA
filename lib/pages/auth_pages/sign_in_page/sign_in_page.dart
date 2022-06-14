import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/blocs/authentication_bloc/authentification_bloc.dart';
import 'package:usainua/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:usainua/pages/auth_pages/additional_data_collection_page/additional_data_collection_page.dart';
import 'package:usainua/pages/auth_pages/credential_linking_page/credential_linking_page.dart';
import 'package:usainua/pages/auth_pages/sign_up_page/sign_up_page.dart';
import 'package:usainua/pages/auth_pages/verification_code_page/verification_code_page.dart';
import 'package:usainua/pages/main_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/helpers/in_app_notification.dart';
import 'package:usainua/utils/validators/phone_validator.dart';
import 'package:usainua/widgets/buttons/icon_text_button.dart';
import 'package:usainua/widgets/buttons/service_auth_button.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/text/rich_text_wrapper.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  static const routeName = '/sign_in_page';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isPageLoading = false;

  void _signUp() {
    Navigator.of(context).pushReplacementNamed(
      SignUpPage.routeName,
    );
  }

  void _signIn() {
    bool isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      context.read<AuthentificationBloc>().add(
            AuthentificationWithPhoneNumber(
              phoneNumber: toNumericString(
                _phoneController.text,
              ),
            ),
          );
    }
  }

  void _googleAuth() {
    context.read<AuthentificationBloc>().add(
          AuthentificationWithGoogle(),
        );
  }

  void _facebookAuth() {
    context.read<AuthentificationBloc>().add(
          AuthentificationWithFacebook(),
        );
  }

  Future<void> _onCodeSend({
    required String verificationID,
  }) async {
    AuthCredential? authCredential = await Navigator.of(context).pushNamed(
      VerificationCodePage.routeName,
      arguments: VerificationCodePageParameters(
        phoneNumber: toNumericString(
          _phoneController.text,
        ),
        verificationID: verificationID,
      ),
    ) as AuthCredential?;

    if (authCredential != null) {
      setState(() {
        _isPageLoading = true;
      });
      context.read<AuthentificationBloc>().add(
            AuthentificationWithAuthCredential(
              authCredential: authCredential,
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

          setState(() {
            _isPageLoading = false;
          });
        }

        if (state is AuthentificationCodeSend) {
          _onCodeSend(verificationID: state.verificationId);
        }

        if (state is SocialNetworksNeedMoreData) {
          Navigator.of(context).pushNamed(
            AdditionalDataCollectionPage.routeName,
            arguments: AdditionalDataCollectionPageParameters(
              authCredential: state.authCredential,
              userModel: state.userModel,
            ),
          );
        }

        if (state is AuthentificationWithTheSameCredential) {
          Navigator.of(context).pushNamed(
            CredentialLinkingPage.routeName,
            arguments: CredentialLinkingPageParameters(
              authType: state.authType,
              mainAuthCredential: state.authCredential,
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Вход',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.042,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldWithCustomLabel(
                          controller: _phoneController,
                          textInputAction: TextInputAction.done,
                          hintText: 'Ваш номер телефона*',
                          keyboardType: TextInputType.phone,
                          onSubmitted: (_) {
                            _signIn();
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
                              errorText: 'Укажите корректный номер телефона',
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.050,
                    ),
                  ),
                  SubmitButton(
                    onTap: _signIn,
                    text: 'ВОЙТИ',
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.030,
                    ),
                  ),
                  RichTextWrapper(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textStyle: const TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.bold,
                      fontSize: AppFonts.sizeXSmall,
                    ),
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      IconTextButton(
                        onTap: _signUp,
                        text: 'Зарегистрироваться',
                        icon: SvgPicture.asset(
                          AppIcons.addUser,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.080,
                    ),
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
                      ServiceAuthButton(
                        text: 'Войти как пользователь',
                        icon: SvgPicture.asset(AppIcons.google),
                        onTap: _googleAuth,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ServiceAuthButton(
                        text: 'Войти как пользователь',
                        icon: SvgPicture.asset(AppIcons.facebook),
                        onTap: _facebookAuth,
                      ),
                    ],
                  ),
                ],
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
