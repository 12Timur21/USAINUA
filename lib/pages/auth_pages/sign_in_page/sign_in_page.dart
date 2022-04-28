import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/pages/auth_pages/widgets/buttons/nav_link_button.dart';
import 'package:usainua/pages/auth_pages/widgets/buttons/service_auth_button.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_validators.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';

import 'package:usainua/widgets/text_fields/custom_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  static const routeName = '/sign_in_page';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

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
              'Вход',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(
              height: 42,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Ваш номер телефона*',
                    formatters: [
                      PhoneInputFormatter(),
                    ],
                    validator: MultiValidator([
                      PhoneValidator(
                        errorText: 'Укажите корректный номер телефона',
                      ),
                    ]),
                  ),
                  CustomTextField(
                    maxLength: 12,
                    obscureText: true,
                    validator: MultiValidator([
                      LengthRangeValidator(
                        min: 5,
                        max: 12,
                        errorText: 'Минимальный размер пароля 5 символов',
                      )
                    ]),
                    hintText: 'Ваш пароль*',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SubmitButton(
              onTap: () {
                bool isValid = _formKey.currentState?.validate() ?? false;

                print(isValid);
              },
              text: 'ВОЙТИ',
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                NavLinkButton(
                  onTap: () {},
                  text: 'Напоминить пароль',
                  icon: SvgPicture.asset(
                    AppIcons.lock,
                  ),
                ),
                NavLinkButton(
                  onTap: () {},
                  text: 'Зарегистрироваться',
                  icon: SvgPicture.asset(
                    AppIcons.addUser,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
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
