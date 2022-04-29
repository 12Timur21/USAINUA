import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_images.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  static const routeName = '/introduction_page';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
            SizedBox(
              height: 330,
              child: Image.asset(
                AppImages.deliveryScene,
              ),
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontFamily: AppFonts.fontFamily,
                  fontWeight: AppFonts.heavy,
                  fontSize: AppFonts.sizeXXLarge,
                  letterSpacing: 0.5,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Добро пожаловать в мир шопинга вместе с USA'),
                  TextSpan(
                    text: 'in',
                    style: TextStyle(
                      color: AppColors.buttonPrimary,
                    ),
                  ),
                  TextSpan(
                    text: 'UA!',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Логин и пароль был отправлен на Ваш e-mail. Если пароль не получен, проверьте папку “СПАМ”',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontFamily: AppFonts.fontFamily,
                fontWeight: AppFonts.regular,
                fontSize: AppFonts.sizeXSmall,
                letterSpacing: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
            SubmitButton(
              onTap: () {},
              text: 'Продолжить',
            ),
          ],
        ),
      ),
    );
  }
}
