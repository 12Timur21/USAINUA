import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/blocs/authentication_bloc/authentification_bloc.dart';
import 'package:usainua/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:usainua/models/user_model.dart';
import 'package:usainua/pages/auth_pages/credential_linking_page/credential_linking_page.dart';
import 'package:usainua/pages/auth_pages/sign_in_page/sign_in_page.dart';
import 'package:usainua/pages/auth_pages/verification_code_page/verification_code_page.dart';
import 'package:usainua/pages/main_pages/main_page.dart';
import 'package:usainua/utils/validators/phone_validator.dart';
import 'package:usainua/widgets/buttons/icon_text_button.dart';
import 'package:usainua/widgets/buttons/service_auth_button.dart';
import 'package:usainua/pages/privacy_terms_page/privacy_terms_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/text/rich_text_wrapper.dart';

import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';
import 'package:usainua/widgets/toasts/error_toast.dart';

import '../additional_data_collection_page/additional_data_collection_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/sign_up_page';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final FToast _fToast = FToast();

  @override
  void initState() {
    _fToast.init(context);
    super.initState();
  }

  bool _isPageLoading = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  void _showPrivacyPolicy() {
    Navigator.of(context).pushNamed(
      PrivacyTermsPage.routeName,
      arguments: 'privacy_policy.md',
    );
  }

  void _alreadySignUp() {
    Navigator.of(context).pushReplacementNamed(
      SignInPage.routeName,
      // (route) => false,
    );
  }

  void _validateFormAndRegister(BuildContext context) {
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
            AuthentificationCreateNewUser(
              authCredential: authCredential,
              userModel: UserModel(
                name: _nameController.text,
                email: _emailController.text,
                phoneNumber: toNumericString(
                  _phoneController.text,
                ),
              ),
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
          ErrorToast.showErrorToast(
            fToast: _fToast,
            errorMessage: state.error,
          );
          setState(() {
            _isPageLoading = false;
          });
        }

        if (state is AuthentificationCodeSend) {
          _onCodeSend(
            verificationID: state.verificationId,
          );
        }

        if (state is SocialNetworksNeedMoreData) {
          print('123');
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
                    'Регистрация',
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
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          maxLength: 35,
                          keyboardType: TextInputType.name,
                          validator: MultiValidator([
                            LengthRangeValidator(
                              min: 1,
                              max: 35,
                              errorText: 'Укажите ваше имя',
                            )
                          ]),
                          hintText: 'Ваше имя*',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWithCustomLabel(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          validator: MultiValidator(
                            [
                              EmailValidator(
                                errorText: 'Укажите корректный email',
                              ),
                              MinLengthValidator(
                                1,
                                errorText: 'Укажите вашу почту',
                              ),
                            ],
                          ),
                          hintText: 'Ваш email*',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWithCustomLabel(
                          controller: _phoneController,
                          textInputAction: TextInputAction.done,
                          hintText: 'Ваш номер телефона*',
                          keyboardType: TextInputType.phone,
                          formatters: [
                            PhoneInputFormatter(),
                          ],
                          validator: MultiValidator(
                            [
                              MinLengthValidator(
                                1,
                                errorText: 'Укажите номер телефона',
                              ),
                              PhoneValidator(
                                errorText: 'Укажите корректный номер телефона',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: AppFonts.sizeXSmall,
                        fontWeight: AppFonts.regular,
                        letterSpacing: 0.75,
                        color: AppColors.darkBlue,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'Регистрируясь, Вы соглашаетесь с '),
                        TextSpan(
                          text: 'пользовательским соглашением',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _showPrivacyPolicy(),
                          style: const TextStyle(
                            height: 1.5,
                            shadows: [
                              Shadow(
                                color: AppColors.darkBlue,
                                offset: Offset(0, -3),
                              )
                            ],
                            color: Colors.transparent,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ),
                  BlocBuilder<AuthentificationBloc, AuthentificationState>(
                    builder: (context, state) {
                      return SubmitButton(
                        onTap: () {
                          _validateFormAndRegister(context);
                        },
                        text: 'ЗАРЕГИСТРИРОВАТЬСЯ',
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.030,
                    ),
                  ),
                  IconTextButton(
                    onTap: _alreadySignUp,
                    text: 'Я уже зарегестрирован',
                    textStyle: const TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.bold,
                      fontSize: AppFonts.sizeXSmall,
                    ),
                    icon: SvgPicture.asset(
                      AppIcons.keyInBox,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.045,
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
