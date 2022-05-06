import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/blocs/authentication_bloc/authentification_bloc.dart';
import 'package:usainua/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:usainua/pages/auth_pages/verification_code_page/verification_code_page.dart';
import 'package:usainua/pages/auth_pages/widgets/buttons/nav_link_button.dart';
import 'package:usainua/pages/auth_pages/widgets/buttons/service_auth_button.dart';
import 'package:usainua/pages/privacy_terms_page/privacy_terms_page.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_validators.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';

import 'package:usainua/widgets/text_fields/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const routeName = '/sign_up_page';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(
    text: 'Timur',
  );
  final _emailController = TextEditingController(
    text: 'timur.sholokh@gmail.com',
  );
  final _phoneController = TextEditingController(
    text: '380969596645',
  );

  void _showPrivacyPolicy() {
    Navigator.of(context).pushNamed(
      PrivacyTermsPage.routeName,
      arguments: 'privacy_policy.md',
    );
  }

  void _alreadySignUp() {
    Navigator.of(context).pop();
  }

  void _validateFormAndRegister(BuildContext context) {
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      context.read<AuthentificationBloc>().add(
            SignUpWithPhoneNumber(
              name: _nameController.text,
              email: _emailController.text,
              phoneNumber: _phoneController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthentificationBloc, AuthentificationState>(
      listener: (context, state) {
        print('call here  1');
        print(state);
        if (state is AuthentificationSuccess) {
          //dsaasdas
        }
        if (state is AuthentificationCodeSend) {
          Navigator.of(context).pushNamed(VerificationCodePage.routeName);
        }
        if (state is AuthentificationFailure) {
          print(state.error);
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
                    CustomTextField(
                      controller: _nameController,
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
                    CustomTextField(
                      controller: _emailController,
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
                    CustomTextField(
                      controller: _phoneController,
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
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Регистрируясь, Вы соглашаетесь с '),
                    TextSpan(
                      text: 'пользовательским соглашением',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _showPrivacyPolicy(),
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
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
              NavLinkButton(
                onTap: _alreadySignUp,
                text: 'Я уже зарегестрирован',
                icon: SvgPicture.asset(
                  AppIcons.keyInBox,
                ),
              ),
              // const SizedBox(
              //   height: 45,
              // ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.045,
                ),
              ),

              BlocBuilder<AuthentificationBloc, AuthentificationState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      ServiceAuthButton(
                        text: 'Войти как пользователь',
                        icon: SvgPicture.asset(AppIcons.google),
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ServiceAuthButton(
                        text: 'Войти как пользователь',
                        icon: SvgPicture.asset(AppIcons.facebook),
                        onTap: () {},
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
