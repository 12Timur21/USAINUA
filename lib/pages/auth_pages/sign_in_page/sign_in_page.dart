import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/blocs/authentication_bloc/authentification_bloc.dart';
import 'package:usainua/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:usainua/pages/auth_pages/remind_password_page/remind_password_page.dart';
import 'package:usainua/pages/auth_pages/sign_up_page/sign_up_page.dart';
import 'package:usainua/pages/auth_pages/verification_code_page/verification_code_page.dart';
import 'package:usainua/pages/auth_pages/widgets/buttons/nav_link_button.dart';
import 'package:usainua/pages/auth_pages/widgets/buttons/service_auth_button.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_validators.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/text/rich_text_widget.dart';

import 'package:usainua/widgets/text_fields/custom_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  static const routeName = '/sign_in_page';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  void _signUp() {
    print('text');
    Navigator.of(context).pushNamed(
      SignUpPage.routeName,
    );
  }

  void _signIn() {
    bool isValid = _formKey.currentState?.validate() ?? false;
    Navigator.of(context).pushNamed(
      VerificationCodePage.routeName,
    );
    print(isValid);
  }

  void _remindPassword() {
    Navigator.of(context).pushNamed(
      RemindPasswordPage.routeName,
    );
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
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.042,
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(
            //     top: 42 * MediaQuery.of(context).size.aspectRatio,
            //   ),
            // ),
            // SizedBox(
            //   height: 42,
            // ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _phoneController,
                    hintText: 'Ваш номер телефона*',
                    keyboardType: TextInputType.phone,
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

            RichTextWidgets(
              crossAxisAlignment: CrossAxisAlignment.start,
              textStyle: TextStyle(
                  // color: AppColors
                  ),
              children: [
                NavLinkButton(
                  onTap: _remindPassword,
                  text: 'Напоминить пароль',
                  icon: SvgPicture.asset(
                    AppIcons.lock,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                NavLinkButton(
                  onTap: _signUp,
                  text: 'Зарегистрироваться',
                  icon: SvgPicture.asset(
                    AppIcons.addUser,
                  ),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 80,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(
            //     top: 80 * MediaQuery.of(context).size.aspectRatio,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.080,
              ),
            ),
            Column(
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
    );
  }
}
