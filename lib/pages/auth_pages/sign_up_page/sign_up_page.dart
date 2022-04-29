import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
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

  void _showPrivacyPolicy() {
    Navigator.of(context).pushNamed(
      PrivacyTermsPage.routeName,
      arguments: 'privacy_policy.md',
    );
  }

  void _alreadySignUp() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            // const SizedBox(
            //   height: 42,
            // ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
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
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator(
                      [
                        EmailValidator(
                          errorText: 'Укажите корректный email',
                        )
                      ],
                    ),
                    hintText: 'Ваш email*',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
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
                  // CustomTextField(
                  //   maxLength: 12,
                  //   obscureText: true,
                  //   validator: MultiValidator([
                  //     LengthRangeValidator(
                  //       min: 5,
                  //       max: 12,
                  //       errorText: 'Минимальный размер пароля 5 символов',
                  //     )
                  //   ]),
                  //   hintText: 'Ваш пароль*',
                  // ),
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
            SubmitButton(
              onTap: () {
                bool isValid = _formKey.currentState?.validate() ?? false;
                print(isValid);
              },
              text: 'ЗАРЕГИСТРИРОВАТЬСЯ',
            ),
            // const SizedBox(
            //   height: 30,
            // ),

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

            Column(
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
            ),
          ],
        ),
      ),
    );
  }
}
