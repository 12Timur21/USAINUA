import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/pages/auth_pages/widgets/buttons/nav_link_button.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/text_fields/custom_text_field.dart';

class RemindPasswordPage extends StatelessWidget {
  const RemindPasswordPage({Key? key}) : super(key: key);

  static const routeName = '/remind_password_page';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();

    void _alreadySignUp() {
      Navigator.of(context).pop();
    }

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
              'ВХОД',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Введите эл. почту или телефон',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: AppFonts.bold,
                fontSize: AppFonts.sizeSmall,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator([
                      EmailValidator(
                        errorText: 'Укажите корректный email',
                      )
                    ]),
                    hintText: 'Ваш email*',
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
            const SizedBox(
              height: 40,
            ),
            NavLinkButton(
              onTap: _alreadySignUp,
              text: 'Я вспомнил свой пароль',
              icon: SvgPicture.asset(
                AppIcons.keyInBox,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
